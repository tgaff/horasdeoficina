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
  let(:page) { CourseCalendarPage.new }
  let(:load_page) { render; page.load rendered }
  before do
    assign :course_info, course_info
    assign :wtbs, wtbs
    assign :course_participants, course_participants
  end

  it 'has a calendar' do
    load_page
    expect(page).to have_calendar
    # calendar contents rendered by JS, can't validate here
  end

  xit 'has the right number of educator checkboxes' do
    load_page
    page.load(rendered)
    pending 'not implemented yet'
  end

  it 'has a list of excluded students' do
    load_page
    expect(page).to have_excluded_students_table
    expect( page.excluded_students_table.all('tr').count ).to eq 4
  end

  it 'has a list of included students' do
    load_page
    expect(page).to  have_included_students_table
  end
end
