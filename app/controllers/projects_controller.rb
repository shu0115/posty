class ProjectsController < ApplicationController
  permits :name

  # GET /projects
  def index
    @projects = Project.order(created_at: :desc)
    @project  = Project.new
  end

  # GET /projects/1/edit
  def edit(id)
    @project = Project.mine(current_user).find_by(id: id)
  end

  # POST /projects
  def create(project)
    @project = current_user.projects.build(project)

    if @project.save
      redirect_to projects_url and return
    else
      @projects = Project.order(created_at: :desc)
      render action: 'index'
    end
  end

  # PUT /projects/1
  def update(id, project)
    @project = Project.mine(current_user).find_by(id: id)

    if @project.update(project)
      redirect_to projects_url
    else
      render action: 'edit'
    end
  end

  # DELETE /projects/1
  def destroy(id)
    @project = Project.mine(current_user).find_by(id: id)
    @project.destroy

    redirect_to projects_url
  end
end
