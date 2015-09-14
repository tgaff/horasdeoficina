require 'rails_helper'

RSpec.describe CourseCalendarsController, type: :controller do

  describe "GET #show" do
    let(:course) { FactoryGirl.build_stubbed(:course) }
    let(:course_participants) { FactoryGirl.build_stubbed_list(:course_participant, 4) }
    let(:wtbs) { [ FactoryGirl.build(:weekly_time_block) ] } # reuse for each of 4 CPs
    before do
      allow(Course).to receive(:find).with(2).and_return course
      allow(course).to receive(:course_participants).and_return course_participants
      course_participants.each do | cp |
        allow(cp).to receive(:weekly_time_blocks).and_return wtbs
      end
      allow(WeeklyTimeBlock).to receive(:where).and_return(wtbs*4)
    end

    it "returns http success" do
      get :show, course_id: 2
      expect(response).to have_http_status(:success)
    end

    it "assigns @course_participants" do
      get :show, course_id: 2
      expect(assigns(:course_participants)).to eq course_participants
    end

    it "assigns @course_info" do
      get :show, course_id: 2
      expect(assigns(:course_info)).to eq({ title: course.title })
    end

    it "assigns @wtbs" do
      get :show, course_id: 2
      expect(assigns(:wtbs)).to eq(wtbs*4)
    end

    it "uses the calendar layout" do
      get :show, course_id: 2
      expect(response).to render_with_layout('calendar_layout')
    end

  end

end
