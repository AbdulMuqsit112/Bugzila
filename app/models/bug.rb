class Bug < ApplicationRecord
  belongs_to :project
  has_many_attached :images 
  belongs_to :qa ,class_name: "User", foreign_key: :qa_id
  belongs_to :developer, class_name: "User", foreign_key: :developer_id, optional: true
  validates :title, presence: true, uniqueness: { scope: :project_id}
  validates :bug_type, presence: true 
  validates :bug_status, presence: true
  validates :deadline, presence: true
  validate :image_type, :is_qa, :is_developer, :check_status, :check_project_id ,:check_can_edit , :check_staus_creation


  enum bug_type: {
    bug: 0,
    feature: 1
  }
  
  enum bug_status: {
    New: 0,
    started: 1,
    resolved: 2,
    completed: 3
  }
  def name_with_type
    "#{bug_status}"
  end
  
  private
  
  def image_type
    images.each do |image| 
      if !image.content_type.in?(%('image/gif image/png')) 
        errors.add(:images, "needs to be a gif or png!")
      end
      if image.byte_size > 5.megabytes
        errors.add(:images, 'size is greater than 5Mbs')
      end
    end 
  end

  def is_qa
    b = get_bug
    if !b.nil?
      self.errors.add(:qa, 'Can not change Qa') if b.qa !=self.qa
    else 
      if !self.qa.nil?
        self.errors.add(:qa, 'Invalid User Role') if !self.qa.qa?
      end
    end
  end

  def is_developer
    b = get_bug
    if !b.nil?
      if !self.developer.nil?
        self.errors.add(:developer, 'Invalid User') if !b.project.developers.find_by_id(self.developer.id)
      end 
    else
      if !self.developer.nil?
        self.errors.add(:developer, 'Invalid User') if !self.project.developers.find_by_id(self.developer.id)
      end
    end
  end

  def get_bug
    b = nil
    b = Bug.find(self.id) if !self.id.nil?
  end

  def check_status
    if self.bug?
      self.errors.add(:bug_status, "Invalid: A bug can not contain a status value #{self.bug_status} ") if self.completed?
    else
      self.errors.add(:bug_status, "Invalid: A feature can not contain a status value #{self.bug_status} ") if self.resolved?
    end 
  end

  def check_project_id
    b =nil
    b = Bug.find(self.id) if !self.id.nil?
    if b !=nil
      if b.project !=self.project
        self.errors.add(:project, "Bug does not belong to this project")
      end
    end
  end

  def check_can_edit
    b = get_bug
    if !b.nil?
      if !b.developer.nil?
        self.errors.add(:bug, "Can not edit anymore")
      end
    end
  end

  def check_staus_creation
    b = get_bug
    if b.nil?
      self.errors.add(:bug, "Can not add this status") if self.bug_status == "resolved"
      self.errors.add(:bug, "Can not add this status") if self.bug_status == "completed"
    else
      if self.bug_status == "resolved"
      self.errors.add(:bug, "Can not add this status") if self.developer.nil?
      end
      if self.bug_status =="completed"
        self.errors.add(:bug, "Can not add this status") if self.developer.nil?
      end
    end
  end

end
