require 'rails_helper'

RSpec.feature "Class Participants",
  %q{
    In order to have a listing of times
    As a class participant
    I want to create and manage schedule times
  },
  :js do


  background do
    cp = FactoryGirl.create(:class_participant)
    FactoryGirl.create(:weekly_time_block, class_participant: cp)
  end

  scenario 'the calendar is displayed in week view' do
    visit class_participants_path
    expect(page).to have_css('#calendar .fc-agendaWeek-view')
    expect(page.find('#calendar')).to have_css('.fc-day-header', count: 7)
  end

end
