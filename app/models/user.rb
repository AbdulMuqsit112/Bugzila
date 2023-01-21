class User < ApplicationRecord
  has_many :admin_projects, class_name: "Project", foreign_key: :admin_id, dependent: :destroy 
  has_many :project_developers
  has_many :projects, through: :project_developers
  has_many :bug_developers, class_name: "Bug", foreign_key: :developer_id
  has_many :bugs, class_name: "Bug", foreign_key: :qa_id
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # validate :allow_projects_for_developer
    
  enum user_role: {
    developer: 0,
    qa: 1,
    admin: 2
  }
         
  def name_with_type
    "#{name} - #{user_role}"
  end

  private

  # def allow_projects_for_developer
  #   if !self.developer?
  #     self.errors.add(:user_role, 'Invalid Entry') if !self.projects.nil?
  #   end
  # end


end
