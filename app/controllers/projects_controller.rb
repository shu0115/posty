class ProjectsController < ApplicationController
  permits :name

  before_action :set_project, only: [:edit, :update, :destroy]

  # GET /projects
  def index
    @projects = Project.mine(current_user).order(created_at: :desc)
    @project  = Project.new
  end

  # GET /projects/1/edit
  def edit(id)
  end

  # POST /projects
  def create(project)
    @project = current_user.projects.build(project)

    if @project.save
      redirect_to projects_url and return
    else
      @projects = Project.mine(current_user).order(created_at: :desc)
      render action: 'index'
    end
  end

  # PUT /projects/1
  def update(id, project)
    if @project.update(project)
      redirect_to projects_url
    else
      render action: 'edit'
    end
  end

  # DELETE /projects/1
  def destroy(id)
    @project.destroy

    redirect_to projects_url
  end

  private

  def set_project
    @project = Project.mine(current_user).find_by(id: params[:id])

    redirect_to root_path and return if @project.blank?
  end
end
