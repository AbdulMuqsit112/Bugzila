class Project < ApplicationRecord
  has_many :bugs, dependent: :destroy
  has_many :project_developers
  has_many :developers, through: :project_developers
  # has_many :users, through: :project_developers
  belongs_to :admin, class_name: "User", foreign_key: :admin_id
  validate :is_admin, :is_developer
  validates :title, presence: true
  validates :description, presence: true
  validates :developers, presence: true


  
  private

  def is_admin
    p = get_project
    if !p.nil?
      self.errors.add(:admin, 'Can not change Admin') if p.admin !=self.admin
    else 
      if !self.admin.nil?
        self.errors.add(:admin, 'Invalid User Role') if !self.admin.admin?
      end
    end
  end

  def is_developer
    check_developers if !self.developers.nil?
  end

  def get_project
    p = nil
    p = Project.find(self.id) if !self.id.nil?
  end

  def check_developers
    self.developers.each do |developer|
      if !developer.developer?
        self.errors.add(:developer, 'Invalid User Role')
      end
    end
  end

end
