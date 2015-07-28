require 'rails_helper'

RSpec.describe UsualSuspectsController, type: :controller do

  describe "GET #readme" do
    it "returns http success" do
      get :readme
      expect(response).to have_http_status(:success)
    end
  end

end
