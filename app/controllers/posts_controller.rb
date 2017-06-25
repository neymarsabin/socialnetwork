class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show,:destroy,:update,:edit,:upvote,:downvote]

  def index
    @posts = Post.all
  end
  
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.save
    redirect_to root_path
  end

  def show
    @comments = @post.comments
    @comment = Comment.new
    @comment.post_id = @post.id
    @comment.user_id = current_user.id
  end 

  def edit
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

  def upload_image
    render :josn => FroalaEditorSDK::Image.upload(params)
  end
  
  def upvote
    @post.upvote_from current_user
    redirect_to :back
  end
  
  def downvote
    @post.downvote_from current_user
    redirect_to :back
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title,:body)
  end
end
