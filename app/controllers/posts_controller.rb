class PostsController < ApplicationController
  permits :project, :content

  # GET /posts
  def index
    @posts = Post.mine(current_user).order(updated_at: :desc)
    @post  = Post.new
  end

  # GET /posts/1/edit
  def edit(id)
    @post = Post.mine(current_user).find_by(id: id)
  end

  # POST /posts
  def create(post)
    @post = current_user.posts.build(post)

    if @post.save
      redirect_to posts_path
    else
      @posts = Post.mine(current_user).order(updated_at: :desc)
      render action: 'index'
    end
  end

  # PUT /posts/1
  def update(id, post)
    @post = Post.mine(current_user).find_by(id: id)

    if @post.update(post)
      redirect_to posts_path and return
    else
      render action: 'edit'
    end
  end

  # DELETE /posts/1
  def destroy(id)
    @post = Post.mine(current_user).find_by(id: id)
    @post.destroy

    redirect_to posts_url
  end
end
