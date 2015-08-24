require 'rails_helper'

RSpec.describe "courses/index", type: :view do
  before(:each) do
    @student_participant = FactoryGirl.create(:student_participant)
    @educator_participant = FactoryGirl.create(:educator_participant)
    assign(:courses, [
      Course.create!(
        :title => "Title",
        course_participants: [ @student_participant ]
      ),
      Course.create!(
        :title => "Title",
        course_participants: [ @educator_participant ]
      )
    ])


  end

  it "renders a list of courses" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end

  it 'has a heading for each role' do
    render
    expect(rendered).to have_css('h2', text: 'Learning')
    expect(rendered).to have_css('h2', text: 'Teaching')
  end

  it "doesn't show the heading or table if the role isn't present" do
    assign(:courses, [] )
    expect(rendered).to_not have_content 'Teaching'
  end
end
