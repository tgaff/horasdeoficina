require 'rails_helper'

RSpec.describe CourseParticipantsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let!(:course) { FactoryGirl.create(:course_for_user, user: user) }
  let(:participant) { course.course_participants.last }

  describe "GET #edit_calendar" do
    before do
      sign_in user
      2.times { FactoryGirl.create(:weekly_time_block, course_participant_id: participant.id) }
    end
    it "returns http success" do
      get :edit_calendar, course_id: course.id
      expect(response).to have_http_status(:success)
    end
    it "assigns the weekly time blocks belonging to the user and course" do
      get :edit_calendar, course_id: course.id
      expect(assigns(:wtbs)).to eq WeeklyTimeBlock.where(course_participant_id: participant.id)
    end
    it "uses the calendar layout" do
      get :edit_calendar, course_id: course.id
      expect(response).to render_with_layout('calendar_layout')
    end
    it 'assigns @course_info to include the course_title' do
      get :edit_calendar, course_id: course.id
      expect(assigns(:course_info)[:course_title]).to eq course.title
    end


    context 'when not signed-in' do
      it 'redirects to sign-in page' do
        sign_out user
        get :edit_calendar, course_id: course.id
        expect(response).to redirect_to new_user_session_path
      end
    end
    context "when accessing a course the user doesn't possess" do
      it "404s" do
        new_course = FactoryGirl.create(:course_for_user)
        expect { get :edit_calendar, course_id: new_course.id }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe 'POST #save_calendar' do

    let(:calendar_data) do
      URI.encode( [ { start: momentjs_time(3, '11:00'),
                      end: momentjs_time(3, '13:00'),
                      title: 'busy' },
                    { start: momentjs_time(4, '11:00'),
                      end: momentjs_time(4, '14:00'),
                      title: 'busy' },
                    { start: momentjs_time(5, '11:00'),
                      end: momentjs_time(5, '15:00'),
                      title: 'foofle' },
                  ].to_json
                )
    end

    before { sign_in user }

    it 'redirects back to itself' do
      post :save_calendar, course_id: course.id, wtbs: calendar_data
      expect(response).to redirect_to(course_edit_calendar_path)
    end

    it 'breaks the wtbs into components' do
      expect(WeeklyTimeBlock.all.count).to eq 0
      post :save_calendar, course_id: course.id, wtbs: calendar_data
      expect(WeeklyTimeBlock.all.count).to eq 3
      expect(WeeklyTimeBlock.where({ from: (DateTime.new(2015,8,4)..DateTime.new(2015,8,4,23,59)) }).last.to)
        .to eq DateTime.new(2015,8,4,14,0)
    end

    it 'strips off any nuisance time zone data' do
      post :save_calendar, course_id: course.id, wtbs: uri_jsonify([ { start: '2015-08-03T13:00:00-09:00',
                                                         end: '2015-08-03T14:00:00-10:00',
                                                         title: 'BUSY' }])
      expect(WeeklyTimeBlock.last.from).to eq DateTime.parse "2015-08-03T13:00:00-00:00"
      expect(WeeklyTimeBlock.last.to).to eq DateTime.parse "2015-08-03T14:00:00-00:00"

    end
    it 'saves the wtbs with the correct course_participant id' do
      post :save_calendar, course_id: course.id, wtbs: calendar_data
      WeeklyTimeBlock.all.each do |wtb|
        expect(wtb.course_participant).to eq participant
      end
    end

    describe 'removing previous wtbs' do
      let!(:wtb1) { FactoryGirl.create(:weekly_time_block, course_participant: user.reload.course_participants.last) }
      it 'removes the previous wtbs before saving new ones' do
        post :save_calendar, course_id: course.id, wtbs: calendar_data
        expect(WeeklyTimeBlock.find_by_id(wtb1.id)).to be nil
      end
      it "doesn't remove wtbs from other users" do
        user2 = FactoryGirl.create(:user, :with_courses, count: 2)
        expect(user2.course_participants.count).to eq 2
        user2.course_participants.first.weekly_time_blocks << FactoryGirl.create(:weekly_time_block)

        post :save_calendar, course_id: course.id, wtbs: calendar_data
        expect(user2.reload.course_participants.first.weekly_time_blocks.count).to eq 1
      end
      it "doesn't remove wtbs from this user's other courses" do
        cp = FactoryGirl.create(:course_for_user, user: user).course_participants.last
        FactoryGirl.create_list(:weekly_time_block, 2, course_participant: cp)
        post :save_calendar, course_id: course.id, wtbs: calendar_data
        expect(WeeklyTimeBlock.all.count).to eq 5
      end
    end
  end
end
