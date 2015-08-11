require 'rails_helper'

RSpec.describe ClassParticipantsController, type: :controller do

  describe "GET #show" do
    let(:participant_id) { FactoryGirl.create(:class_participant).id }
    before do
      2.times { FactoryGirl.create(:weekly_time_block, class_participant_id: participant_id) }
    end
    it "returns http success" do
      get :show, id: participant_id
      expect(response).to have_http_status(:success)
    end
    it "assigns the weekly time blocks belonging to the user" do
      get :show, id: participant_id
      expect(assigns(:wtbs)).to eq WeeklyTimeBlock.where(class_participant_id: participant_id)
    end
    it "uses the calendar layout" do
      get :show, id: participant_id
      expect(response).to render_with_layout('calendar_layout')
    end
  end

  describe 'GET #last' do
    let!(:participant) { FactoryGirl.create(:class_participant) }
    it 'redirects to the last one' do
      get :last
      expect(response).to redirect_to(participant)
    end
  end

  describe 'POST #save_calendar' do
    let!(:participant) { FactoryGirl.create(:class_participant) }
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

    it 'redirects back to itself' do
      post :save_calendar, id: participant.id, wtbs: calendar_data
      expect(response).to redirect_to(participant)
    end

    it 'breaks the wtbs into components' do
      expect(WeeklyTimeBlock.all.count).to eq 0
      post :save_calendar, id: participant.id, wtbs: calendar_data
      expect(WeeklyTimeBlock.all.count).to eq 3
      expect(WeeklyTimeBlock.where({ from: (DateTime.new(2015,8,4)..DateTime.new(2015,8,4,23,59)) }).last.to)
        .to eq DateTime.new(2015,8,4,14,0)
    end

    it 'strips off any nuisance time zone data' do
      post :save_calendar, id: participant.id, wtbs: uri_jsonify([ { start: '2015-08-03T13:00:00-09:00',
                                                         end: '2015-08-03T14:00:00-10:00',
                                                         title: 'BUSY' }])
      expect(WeeklyTimeBlock.last.from).to eq DateTime.parse "2015-08-03T13:00:00-00:00"
      expect(WeeklyTimeBlock.last.to).to eq DateTime.parse "2015-08-03T14:00:00-00:00"

    end
    it 'saves the wtbs with the correct class_participant id' do
      post :save_calendar, id: participant.id, wtbs: calendar_data
      WeeklyTimeBlock.all.each do |wtb|
        expect(wtb.class_participant).to eq participant
      end
    end
  end
end
