class PostsController < ApplicationController
  permits :project_id, :content

  before_action :set_post, only: [:edit, :update, :destroy, :archive]

  # GET /posts
  def index(project_id)
    redirect_to root_path and return if Project.mine(current_user).where(id: project_id).blank?

    @posts = Post::ActivePost.mine(current_user).where(project_id: project_id).order(updated_at: :desc)
    @post  = Post::ActivePost.new(project_id: project_id)
  end

  # GET /posts/1/edit
  def edit(id)
  end

  # POST /posts
  def create(post_active_post)
    @post = current_user.posts.build(post_active_post.permit!)

    if @post.save
      redirect_to project_posts_path(@post.project_id)
    else
      @posts = Post::ActivePost.mine(current_user).order(updated_at: :desc)
      render action: 'index'
    end
  end

  # PUT /posts/1
  def update(id, post_active_post)
    if @post.update(post_active_post.permit!)
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

  # アーカイブ化
  def archive
    @post.type       = 'Post::ArchivePost'
    @post.archive_at = Time.now
    @post.save!

    redirect_to project_posts_path(@post.project_id) and return
  end

  # アーカイブ一覧
  def archives(project_id)
    @project = Project.mine(current_user).find_by(id: project_id)

    redirect_to root_path and return if @project.blank?

    @posts = Post::ArchivePost.mine(current_user).where(project_id: project_id).order(archive_at: :desc)
  end

  # アクティブへ戻す
  def restore(id)
    @post = Post::ArchivePost.mine(current_user).find_by(id: id)
    @post.type = 'Post::ActivePost'
    @post.save!

    redirect_to project_archives_path(@post.project_id) and return
  end

  private

  def set_post
    @post = Post::ActivePost.mine(current_user).find_by(id: params[:id])

    redirect_to root_path and return if @post.blank?
  end
end
