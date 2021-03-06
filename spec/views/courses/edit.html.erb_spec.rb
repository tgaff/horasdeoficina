require 'rails_helper'

RSpec.describe "courses/edit", type: :view do
  before(:each) do
    @course = FactoryGirl.build_stubbed(:course, title: 'MyString')
    assign :course, @course
    users = { students: FactoryGirl.attributes_for_list(:user, 7),
              educators: FactoryGirl.attributes_for_list(:user, 2)
    }
    allow(view).to receive(:user_courses_by_type).and_return(users)
  end

  it "renders the edit course form" do
    render
    assert_select "form[action=?][method=?]", course_path(@course), "post" do
      assert_select "input#course_title[name=?]", "course[title]"
    end
  end

  it 'has a Scheduling section' do
    render
    assert_select 'div#scheduling' do
      assert_select 'h2', text: 'Scheduling'
    end
  end

  it 'has a Participants list' do
    render

    assert_select 'div#participants' do
      assert_select 'h2', text: 'Course Participants'
    end
  end

  describe 'scheduling section' do
    it 'has two calendar images' do
      render
      assert_select 'div#scheduling img', count: 2
    end
    it 'has a link to calendar page' do
      render
      expect(capybara.find('div#scheduling a')['href']).to match course_edit_calendar_path(@course)
    end
  end

  describe 'participants section' do

    it 'has a list of students' do
      render
      assert_select 'div#participants' do
        assert_select 'h3', text: 'students'
        assert_select 'table.type-students tbody tr', count: 7
      end
    end
    it 'has a list of teachers' do
      render
      assert_select 'div#participants' do
        assert_select 'h3', text: 'educators'
        assert_select 'table.type-educators tbody tr', count: 2
      end
    end
    it "doesn't display sections for which there are no entries" do
      allow(view).to receive(:user_courses_by_type).and_return({students: [], other: []})
      render

      expect(rendered).to_not have_selector('table.type-students')
      expect(rendered).to_not have_selector('table.type-educators')
    end
  end
end
