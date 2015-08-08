require 'rails_helper'

RSpec.describe WeeklyTimeBlocksController, type: :controller do

  let(:wtb1) { FactoryGirl.create(:weekly_time_block) }

  describe "GET #index" do
    before do
      2.times { FactoryGirl.create(:weekly_time_block) }
    end
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "sets the wtbs" do
      get :index
      expect(assigns(:wtbs)).to eq WeeklyTimeBlock.all
    end
  end

  describe "POST #create" do
    let(:valid_attrs) { {to: Time.new(2015,8,4,'12:00'), from: Time.new(2015,8,4,'9:00')} }
    it "returns http success" do
      request.accept = "application/json"
      post :create, wtb: valid_attrs
      expect(response).to have_http_status(:success)
    end
    it "creates a new weekly time block" do
      doub = instance_double('WeeklyTimeBlock', valid_attrs)
      # sigh, why do we still not have a good pattern for stubbing out the model?
      # https://www.relishapp.com/rspec/rspec-rails/docs/upgrade#extract-stub-model
      expect(WeeklyTimeBlock).to receive(:new).and_return(doub)
      expect(doub).to receive(:save).and_return(true)
      expect(doub).to receive(:to_json).and_return({})
      request.accept = 'application/json'
      post :create, wtb: valid_attrs
    end


    it 'has the right time in the new wtb' do
      request.accept = "application/json"
      post :create, wtb: valid_attrs
      expect(WeeklyTimeBlock.last.from.utc.iso8601).to match Time.new(2015,8,4,9,0).utc.iso8601
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, id: wtb1.id, format: :json
      expect(response).to have_http_status(:success)
    end
    it "sends valid wtb attributes" do
      get :show, id: wtb1.id, format: :json
      expect(JSON.parse(response.body)).to eq JSON.parse(wtb1.to_json)
    end

  end

  describe "DELETE #destroy" do
    it "returns http success" do
      request.accept = "application/json"
      delete :destroy, id: wtb1.id
      expect(response).to have_http_status(:success)
    end
    it "deletes the record" do
      request.accept = "application/json"
      delete :destroy, id: wtb1.id
      expect(WeeklyTimeBlock.where(id: wtb1.id)).to be_blank
    end
  end

  describe "PUT #update" do
    let(:edited) { { from: '1:00', to: '23:00' } }

    it "returns http success" do
      request.accept = "application/json"
      put :update, id: wtb1.id, wtb: edited
      expect(response).to have_http_status(:success)
    end
  end

end
