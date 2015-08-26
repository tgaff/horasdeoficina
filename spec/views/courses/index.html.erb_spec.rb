require 'rails_helper'

RSpec.describe "courses/index", type: :view do
  before(:each) do
    @student_participant = FactoryGirl.create(:student_participant)
    @educator_participant = FactoryGirl.create(:educator_participant)
    assign(:courses, [
      Course.create!(
        :title => "Study habits",
        course_participants: [ @student_participant ]
      ),
      Course.create!(
        :title => "Teaching habits",
        course_participants: [ @educator_participant ]
      )
    ])
    sign_in user
  end
  let!(:user) { FactoryGirl.create(:user) } # needed whenever we use Devise in the view

  it "renders a list of courses" do
    render
    assert_select "tr>td", :text => "Study habits", :count => 1
    assert_select "tr>td", :text => "Teaching habits", :count => 1
  end

  it 'has a heading for each role' do
    render
    expect(rendered).to have_css('h3', text: 'Learning')
    expect(rendered).to have_css('h3', text: 'Teaching')
  end

  it "doesn't show the heading or table if the role isn't present" do
    assign(:courses, [] )
    expect(rendered).to_not have_content 'Teaching'
  end

  it 'displays the right course under the right role' do
    render
    node = Capybara.string(rendered).find('div#teaching')
    expect(node).to have_css('td', text: 'Teaching habits')
    expect(node).to have_css('h3', text: 'Teaching')
    node2 = Capybara.string(rendered).find('div#learning')
    expect(node2).to have_css('h3', text: 'Learning')
    expect(node2).to have_css('td', text: 'Study habits')
  end

  it "says 'My courses'" do
    render
    assert_select "h2", text: 'My Courses'
  end

  it 'shows the user info at the top' do
    allow(view).to receive(:current_user) { user }
    render
    assert_select 'h2', text: user.email
  end
end
