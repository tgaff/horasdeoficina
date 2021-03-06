# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  role_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Role < ActiveRecord::Base
  has_many :course_participants

  before_validation :downcase_role_name

  validates :role_name, presence: true
  validates :role_name, uniqueness: { case_sensitive: false }


  def downcase_role_name
    self.role_name = self.role_name.downcase if self.role_name
  end

  def self.student
    where(role_name: 'student').last || create(role_name: 'student')
  end
  def self.educator
    where(role_name: 'educator').last || create(role_name: 'educator')
  end
end
