class ProjectsController < ApplicationController

  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
  	@projects = Project.order :name
  end

  def show
  end

  def new
  	@project = Project.new
  end

  def create
  	@project = Project.new(project_params)

  	if @project.save
  	  flash[:notice] = "Project has been created."
  	  redirect_to @project
  	else
  	  flash.now[:alert] = "Project has not been created."
  	  render "new"
  	end
  end

  def edit
  end

  def update

    if @project.update(project_params)
      redirect_to projects_path, notice: 'Project has been updated.'
    else
      flash.now[:alert] = "Project has not been updated."
      render 'edit'
    end
  end

  def destroy

    @project.destroy
    flash[:notice] = "Project has been destroyed."
    redirect_to projects_path
  end

  private

    def set_project
      begin
        @project = Project.find(params[:id])
      rescue
        redirect_to projects_path, alert: "The project you were looking for cound not be found."
      end
    end

    def project_params
      params.require(:project).permit(:name, :description)
    end
end
