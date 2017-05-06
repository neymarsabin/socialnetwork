class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.save
    redirect_to root_path
  end

  def show
    @post = Post.find(params[:id])
  end 

  private
  def post_params
    params.require(:post).permit(:title,:body)
  end
end
