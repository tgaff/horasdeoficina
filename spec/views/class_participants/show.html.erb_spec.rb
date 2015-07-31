require 'rails_helper'

RSpec.describe "class_participants/show.html.erb", type: :view do
  # this seems dumb....
  it 'shows a calendar' do
    render
    expect(rendered).to have_css('div#calendar')
  end
end
