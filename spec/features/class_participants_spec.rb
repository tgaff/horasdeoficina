require 'rails_helper'

RSpec.feature "Class Participants",
  %q{
    In order to have a listing of times
    As a class participant
    I want to create and manage schedule times
  },
  :js do


  let!(:cp) { FactoryGirl.create(:class_participant) }
  let!(:wtb) { FactoryGirl.create(:weekly_time_block, class_participant: cp) }

  def page_time_format(dt)
    dt.strftime('%l:%M').strip
  end

  scenario 'the calendar is displayed in week view' do
    visit class_participants_path
    expect(page).to have_css('#calendar .fc-agendaWeek-view')
    expect(page.find('#calendar')).to have_css('.fc-day-header', count: 7)
  end

  scenario 'items on the calendar are visible' do
    visit class_participants_path
    expect(page).to have_css(".fc-event-container .fc-time[data-start='#{page_time_format(wtb.from)}']")
  end

  scenario 'items on the calendar can be saved' do
    @page = ClassParticipantsPage.new
    @page.load
    expect(@page.calendar).to have_event(on: 'sunday', at: '3:00 pm')
    @page.calendar.event(on: 'sunday', at: '3:00 pm').drag_to @page.calendar.saturday
    expect(@page.calendar).to have_event(on: 'sat') # we don't know what time this gets dragged to :-/
    @page.calendar.time_row('10am').click
    expect(@page.calendar).to have_event(on: 'wed', at: '10:00 am')
    @page.save_button.click

    expect(@page.calendar).to have_event(on: 'wed', at: '10:00 am')
    expect(@page.calendar).to have_event(on: 'sat')
  end
end
