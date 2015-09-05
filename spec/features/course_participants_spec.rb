require 'rails_helper'

RSpec.feature "Class Participants",
  %q{
    In order to have a listing of times
    As a course participant
    I want to create and manage calendar items
  },
  :js do

  given!(:user) { FactoryGirl.create(:user_with_courses) }
  given!(:cp) { user.course_participants.first }
  given!(:wtb) { FactoryGirl.create(:weekly_time_block, course_participant: cp) }

  def page_time_format(dt)
    dt.strftime('%l:%M').strip
  end

  before do
    UsersSignInPage.sign_in_user user.email
    @page = CourseParticipantsPage.navigate_here
  end

  scenario 'the calendar is displayed in week view' do
    expect(page).to have_css('#calendar .fc-agendaWeek-view')
    expect(page.find('#calendar')).to have_css('.fc-day-header', count: 7)
  end

  scenario 'items on the calendar are visible' do
    expect(page).to have_css(".fc-event-container .fc-time[data-start='#{page_time_format(wtb.from)}']")
  end

  scenario 'items on the calendar can be saved' do
    expect(@page.calendar).to have_event(on: 'sunday', at: '3:00 pm')
    @page.calendar.event(on: 'sunday', at: '3:00 pm').drag_to @page.calendar.saturday
    expect(@page.calendar).to have_event(on: 'sat') # we don't know what time this gets dragged to :-/
    @page.calendar.time_row('10am').click
    expect(@page.calendar).to have_event(on: 'wed', at: '10:00 am')
    @page.save_button.click

    expect(@page.calendar).to have_event(on: 'wed', at: '10:00 am')
    expect(@page.calendar).to have_event(on: 'sat')
  end

  scenario 'the course name is shown' do
    expect(@page).to have_content cp.course.name
  end

  scenario 'the user can go edit the course' do
    @page.course_name_dropdown.click
    @page.course_name_dropdown.edit_link.click
    @page = CourseEditPage.new
    expect(@page).to be_displayed
  end
end
