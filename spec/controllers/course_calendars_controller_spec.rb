require 'rails_helper'

RSpec.describe CourseCalendarsController, type: :controller do

  describe "GET #show" do
    let(:course) { FactoryGirl.build_stubbed(:course) }
    let(:course_participants) { FactoryGirl.build_stubbed_list(:course_participant, 4) }
    before do
      allow(Course).to receive(:find).with(2).and_return course
      allow(course).to receive(:course_participants).and_return course_participants
    end

    it "returns http success" do
      get :show, course_id: 2
      expect(response).to have_http_status(:success)
    end

    it "assigns @course_participants" do
      get :show, course_id: 2
      expect(assigns(:course_participants)).to eq course_participants
    end

    it "uses the calendar layout" do
      get :show, course_id: 2
      expect(response).to render_with_layout('calendar_layout')
    end

  end

end
