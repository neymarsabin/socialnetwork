class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show,:destroy,:update]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.save
    redirect_to root_path
  end

  def show
  end 

  def update
    if current_user == @post.user
      @post.update(post_params)
      @post.save
      flash[:notice] == "Edit successfull: #{@post.title} "
      redirect_to @post
    end
  end


  def destroy
    if current_user == @post.user
      @post.destroy
      flash[:notice] = "Sucessfully deleted the post: #{@post.title}"
      redirect_to root_path
    else
      flash[:notice] = "You are not authorized to delete this post"
      redirect_to post_path
    end
  end
  
  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title,:body)
  end
end
