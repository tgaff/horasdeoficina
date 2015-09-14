require 'rails_helper'

# using site-prism for this view spec

RSpec.describe "course_calendars/show.html.erb", type: :view do
  let(:course_participants) { FactoryGirl.build_stubbed_list(:course_participant, 4) }
  let(:course_info) { { title: 'showmanship' } }
  let(:wtbs) do
    wtbs = FactoryGirl.build_stubbed_list(:weekly_time_block, 3)
    wtbs.each_with_index do |wtb, i|
      wtb.from = wtb.from + i*24.hours
      wtb.to = wtb.to + i*24.hours
    end
    wtbs
  end
  let(:page) { CalendarEditPage.new }
  before do
    assign :course_info, course_info
    assign :wtbs, wtbs
  end

  it 'has a calendar' do
    render
    page.load(rendered)
    expect(page).to have_calendar
    # calendar contents rendered by JS, can't validate here
  end
end
