class PostsController < ApplicationController
  respond_to :js, :html, :json

  before_action :authenticate_user!
  before_action :find_post, only: [:show]

  def index
    @users = User.includes(:posts).all.order(created_at: :desc)
    @user = current_user
    @posts = Post.all.order('created_at DESC')
  end

  def like
    @post = Post.find(params[:id])
    case params[:format]
    when 'like'
      @post.liked_by current_user
      flash[:notice] = 'You liked this post'
    when 'unlike'
      @post.unliked_by current_user
      flash[:notice] = 'You unliked this post'
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    redirect_to user_path(current_user) if @post.save
    # if @post.save
    #   params[:images]&.each { |img| @post.photos.create(image: img) }
    #   redirect_to posts_path
    #   flash[:notice] = 'Saved ...'
    # else
    #   flash[:alert] = 'Something went wrong ...'
    #   redirect_to posts_path
    # end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def find_post
    @post = Post.find_by id: params[:id]
    return if @post

    flash[:danger] = 'Post not exist!'
    redirect_to root_path
  end

  def post_params
    params.require(:post).permit :content, :image
  end
end
