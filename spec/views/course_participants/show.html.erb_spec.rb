require 'rails_helper'

RSpec.describe "course_participants/show.html.erb", type: :view do
  before do
    assign :course_info, {course_title: 'Shoe making'}
    assign :wtbs, []
  end
  # this seems dumb....
  it 'shows a calendar' do
    render
    expect(rendered).to have_css('div#calendar')
  end

  it 'shows the course info' do
    render
    assert 'h1', text: 'My available times for Shoe making'
  end
end
