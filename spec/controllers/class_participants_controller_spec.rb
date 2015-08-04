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
end
