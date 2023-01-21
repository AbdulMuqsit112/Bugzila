class ProjectsController < ApplicationController
  load_and_authorize_resource
  # before_action :authenticate_user!
  
  def index
     @projects = current_user.projects if current_user.developer?
    # @projects = current_user.admin_projects if current_user.admin?
     @projects = Project.all if current_user.qa?

  end

  def show
    # if current_user.developer?
    #   if !@project.developers.find_by_id(current_user.id)
    #     flash[:notice] = "Access Denied"
    #     redirect_to root_path
    #   end
    # end
    # if current_user.admin?
    #   if @project.admin !=current_user
    #     flash[:notice] = "Access Denied"
    #     redirect_to root_path
    #   end
    # end 
  end

  def new
      @project = Project.new
      if !can? :new, @project
          flash[:notice] = "Access Denied"
          redirect_to root_path
      end
  end
  
  def create
    @project.admin = current_user
    if @project.save
      redirect_to @project
    else
      render 'new'
    end
  end

  def edit
  end

  def update 
    if @project.update(project_params)
       redirect_to @project
      flash[:notice] = "Project was successfully edited"
    else
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

 
  protected

  def project_params
    params.require(:project).permit(:title, :description, developer_ids:[])
  end

end