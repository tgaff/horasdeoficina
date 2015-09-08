require 'rails_helper'

RSpec.describe CourseCalendarsController, type: :controller do

  describe "GET #show" do
    it "returns http success" do
      get :show, course_id: 2
      expect(response).to have_http_status(:success)
    end
  end

end
