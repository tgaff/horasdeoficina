require 'rails_helper'

# consider removing this entirely since we cover it in controller spec

RSpec.describe "Courses", type: :request do
  describe "GET /courses" do

    context "when not signed in" do
      it "redirects" do
        get courses_path
        expect(response).to have_http_status(302)
      end
    end
  end
end
