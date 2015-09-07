require 'rails_helper'

RSpec.describe "course_participants/show.html.erb", type: :view do
  before do
    assign :course_info, {course_title: 'Shoe making', course_id: 3}
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

  it 'has a link to edit page' do
    render
    expect(capybara(rendered)).to have_css 'a.dropdown-toggle'
    expect(capybara(rendered).find('ul.dropdown-menu a', text: 'edit course'))
  end

  it 'has the helpful info' do
    render
    expect(capybara(rendered).find('.well.help')).to have_content 'cannot meet at'
  end
end
