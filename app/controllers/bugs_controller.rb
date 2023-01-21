class BugsController < ApplicationController
  load_and_authorize_resource
  before_action :get_project
  before_action :get_bug, except: [:index, :new, :create]

  def index
    head :forbidden if !can? :read, @project
  end  

  def show
    # head :forbidden if !can? :read, @project
  end

  def new
      @bug = @project.bugs.new()
      head :forbidden if !can? :new, @bug  
  end

  def create
    if bug_params[:bug_type] == 'feature'
      bug_params[:bug_status] = feature_status[:feature_status]
    end
     @bug = @project.bugs.new(bug_params)
     @bug.qa = current_user
     if @bug.save
      redirect_to [@project, @bug]
      flash[:notice] = "Bug was sucessfully created"
     else
      flash[:notice] = "Some Error Occured", @bug.errors.full_messages
      render 'new'
     end
  end

  def edit
  end

  def update
    if @bug.bug_type == 'feature'
      bug_params[:bug_status] = feature_status[:feature_status]
      if current_user.developer?
        @bug.developer = current_user if bug_params[:bug_status] =="completed"
      end
    end
    if current_user.developer?
      if @bug.bug_type == 'bug'
        @bug.developer = current_user if bug_params[:bug_status] =="resolved"
      end
    end
    if @bug.update(bug_params)
      redirect_to [@project, @bug]
      flash[:notice] = "Bug was successfully edited"
    else
      render 'edit'
    end

  end

  def destroy
    if @bug.destroy
      flash[:notice] = "Bug was successfully deleted"
      redirect_to project_bugs_path 
    end 
  end

  private

  def feature_status
    params.require(:bug).permit(
      :feature_status
    )
  end
  
  def bug_params
    params.require(:bug).permit(
      :title, 
      :discription, 
      :deadline, 
      :bug_type,
      :bug_status, 
      images: [])
  end

  def get_project
    @project = Project.find(params[:project_id])  
  end

  def get_bug
    @bug = @project.bugs.find(params[:id])
  end

end