class ProjectDeveloper < ApplicationRecord
  belongs_to :project
  belongs_to :user
  belongs_to :developer, class_name: "User", foreign_key: "user_id"
  validate :check_developer

  private
  def check_developer
    self.errors.add(:developer, 'Invalid User') if !self.user.developer? 
  end

end
