class PostsController < ApplicationController
  permits :project_id, :content

  before_action :set_post, only: [:edit, :update, :destroy]

  # GET /posts
  def index(project_id)
    redirect_to root_path and return if Project.mine(current_user).where(id: project_id).blank?

    @posts = Post.mine(current_user).where(project_id: project_id).order(updated_at: :desc)
    @post  = Post.new(project_id: project_id)
  end

  # GET /posts/1/edit
  def edit(id)
  end

  # POST /posts
  def create(post)
    @post = current_user.posts.build(post)

    if @post.save
      redirect_to project_posts_path(@post.project_id)
    else
      @posts = Post.mine(current_user).order(updated_at: :desc)
      render action: 'index'
    end
  end

  # PUT /posts/1
  def update(id, post)
    if @post.update(post)
      redirect_to project_posts_path(@post.project_id) and return
    else
      render action: 'edit'
    end
  end

  # DELETE /posts/1
  def destroy(id)
    @post.destroy

    redirect_to project_posts_path(@post.project_id) and return
  end

  private

  def set_post
    @post = Post.mine(current_user).find_by(id: params[:id])

    redirect_to root_path and return if @post.blank?
  end
end
