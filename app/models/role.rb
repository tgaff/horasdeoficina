class Role < ActiveRecord::Base
  has_many :class_participants

  before_validation :downcase_role_name

  validates :role_name, presence: true
  validates :role_name, uniqueness: { case_sensitive: false }


  def downcase_role_name
    self.role_name = self.role_name.downcase if self.role_name
  end
end
