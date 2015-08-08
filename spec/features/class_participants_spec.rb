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
    # #calendar > div.fc-view-container > div > table > tbody > tr > td > div.fc-time-grid-container.fc-scroller > div > div.fc-content-skeleton > table > tbody > tr > td:nth-child(4) > div > a.fc-time-grid-event.fc-v-event.fc-event.fc-start.fc-not-end.fc-draggable
    # fc-event-container .fc-content .fc-time / .fc-title
    expect(page).to have_css(".fc-event-container .fc-time[data-start='#{page_time_format(wtb.from)}']")
  end
end
