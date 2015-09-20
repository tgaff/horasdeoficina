require 'spec_helper'

describe 'course_calendars/_course_participants.json.jbuilder' do
  let(:cps) { FactoryGirl.build_stubbed_list(:student_participant, 4) }
  let(:parsed) { JSON.parse rendered }
  before do
    cps.each_with_index do |cp, i|
      allow(cp).to receive_message_chain(:user, :id).and_return i
      allow(cp).to receive_message_chain(:user, :email).and_return 'test@test.com'
      allow(cp).to receive_message_chain(:role, :role_name).and_return 'novice'
    end
    assign :course_participants, cps
  end

  it 'is a json array' do
    render
    expect(parsed).to be_a Array
  end

  describe 'attributes from course_participant' do
    it 'has course_participant.id' do
      render

      rendered_ids = parsed.map { |p| p['id'] }
      factory_ids = cps.map { |p| p.id }

      expect(factory_ids).to eq rendered_ids
    end
  end

  describe 'attributes from user' do
    it 'includes user email' do
      render
      rendered_user_emails = parsed.map { |p| p['email'] }
      factory_user_emails = cps.map { |cp| cp.user.email }

      expect(factory_user_emails).to eq rendered_user_emails.reverse
    end
  end

  describe 'attributes from role' do
    it 'includes user role name' do
      render
      rendered_role = parsed.map { |p| p['role'] }
      factory_role = cps.map { |cp| cp.role.role_name }

      expect(rendered_role).to eq factory_role
      expect(parsed.last['role']).to eq 'novice'
    end
  end

end
