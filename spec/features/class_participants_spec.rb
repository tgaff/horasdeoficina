require 'rails_helper'

RSpec.feature "Class Participants",
  %q{
    In order to have an awesome blog
    As an author
    I want to create and manage articles
  },
  :js do


  background do
    cp = FactoryGirl.create(:class_participant)
    FactoryGirl.create(:weekly_time_block, class_participant: cp)
  end


  scenario 'the calendar is displayed' do
    visit class_participants_path
    expect(page).to have_css('#calendar')
  end

end
