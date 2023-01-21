# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(current_user)
    if current_user.present?
       
      if current_user.qa?
        can :read, Project
        can [:new,:create], Bug
        can [:edit, :delete, :update, :read], Bug, qa: current_user
      elsif current_user.admin?
        can :new, Project
        can :manage, Project, admin: current_user
        can :read , Bug
      else
        can :read, Project do |project|
          current_user.projects.find_by_id(project.id).present?
        end
        can [:read, :edit, :update],Bug do |bug|
          current_user.projects.find_by_id(bug.project.id).present?
        end
      end

    end  

  end

end
