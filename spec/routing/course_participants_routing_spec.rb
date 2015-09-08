require "rails_helper"

RSpec.describe CourseParticipantsController, type: :routing do
  describe "routing" do

    it "routes to #edit_calendar" do
      expect(:get => "/courses/1/edit_calendar").to route_to("course_participants#edit_calendar", course_id: '1')
    end

    it "routes to #save_calendar" do
      expect(post: '/courses/1/calendar/update').to route_to('course_participants#save_calendar', course_id: '1')
    end

    xit "routes to #show_calendar" do
      expect(get: '/courses/1/calendar').to route_to('course_participants#course_calendar', course_id: '1')
    end
  end
end
