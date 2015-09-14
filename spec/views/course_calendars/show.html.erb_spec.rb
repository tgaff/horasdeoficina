require 'rails_helper'

RSpec.describe "course_calendars/show.html.erb", type: :view do
  let(:course_participants) { FactoryGirl.build_stubbed_list(:course_participant, 4) }
  let(:course_info) { { title: 'showmanship' } }
  let(:a_wtb) { FactoryGirl.build_stubbed_list(:weekly_time_block, 3) }

  pending "add some examples to (or delete) #{__FILE__}"
end
