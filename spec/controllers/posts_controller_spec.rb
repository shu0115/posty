require 'spec_helper'

describe PostsController do
  # This should return the minimal set of attributes required to create a valid
  # Post. As you add validations to Post, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "project" => "" }
  end

  describe 'GET index' do
    before do
      @post = Post.create! valid_attributes
      controller.index
    end
    describe 'assigns all posts as @posts' do
      subject { controller.instance_variable_get('@posts') }
      it { should eq([@post]) }
    end
  end

  describe 'GET show' do
    before do
      @post = Post.create! valid_attributes
      controller.show(@post.to_param)
    end
    describe 'assigns the requested post as @post' do
      subject { controller.instance_variable_get('@post') }
      it { should eq(@post) }
    end
  end

  describe 'GET new' do
    before do
      controller.new
    end
    describe 'assigns a new post as @post' do
      subject { controller.instance_variable_get('@post') }
      it { should be_a_new(Post) }
    end
  end

  describe 'GET edit' do
    before do
      @post = Post.create! valid_attributes
      controller.edit(@post.to_param)
    end
    describe 'assigns the requested post as @post' do
      subject { controller.instance_variable_get('@post') }
      it { should eq(@post) }
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      before do
        controller.should_receive(:redirect_to) {|u| u.should eq(Post.last) }
      end
      describe 'creates a new Post' do
        it { expect {
          controller.create(valid_attributes)
        }.to change(Post, :count).by(1) }
      end

      describe 'assigns a newly created post as @post and redirects to the created post' do
        before do
          controller.create(valid_attributes)
        end
        subject { controller.instance_variable_get('@post') }
        it { should be_a(Post) }
        it { should be_persisted }
      end
    end

    context 'with invalid params' do
      describe "assigns a newly created but unsaved post as @post, and re-renders the 'new' template" do
        before do
          Post.any_instance.stub(:save) { false }
          controller.should_receive(:render).with(:action => 'new')
          controller.create({ "project" => "invalid value" })
        end
        subject { controller.instance_variable_get('@post') }
        it { should be_a_new(Post) }
      end
    end
  end

  describe 'PUT update' do
    context 'with valid params' do
      describe 'updates the requested post, assigns the requested post as @post, and redirects to the post' do
        before do
          @post = Post.create! valid_attributes
          controller.should_receive(:redirect_to).with(@post, anything)
          controller.update(@post.to_param, valid_attributes)
        end
        subject { controller.instance_variable_get('@post') }
        it { should eq(@post) }
      end
    end

    context 'with invalid params' do
      describe "assigns the post as @post, and re-renders the 'edit' template" do
        before do
          @post = Post.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Post.any_instance.stub(:save) { false }
          controller.should_receive(:render).with(:action => 'edit')
          controller.update(@post.to_param, { "project" => "invalid value" })
        end
        subject { controller.instance_variable_get('@post') }
        it { should eq(@post) }
      end
    end
  end

  describe 'DELETE destroy' do
    before do
      @post = Post.create! valid_attributes
      controller.stub(:posts_url) { '/posts' }
      controller.should_receive(:redirect_to).with('/posts')
    end
    it 'destroys the requested post, and redirects to the posts list' do
      expect {
        controller.destroy(@post.to_param)
      }.to change(Post, :count).by(-1)
    end
  end
end
