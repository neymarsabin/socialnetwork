class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show,:destroy,:update,:edit,:upvote,:downvote]

  def index
    @posts = Post.all
    render formats: [ :html, :json]
  end
  
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if verify_recaptcha(model: @post) && @post.save
      flash[:notice] = "sucessfuly created post"
      redirect_to root_path
    else
      flash[:notice] = "Invalid captcha please submit the form again."
      redirect_to :back
    end
  end

  def show
    @comments = @post.comments
    @comment = Comment.new
    @comment.post_id = @post.id
    @comment.user_id = current_user.id
    @tag_count = @post.tag_list.size
  end 

  def edit
  end 
  def update
    if current_user == @post.user
      @post.update(post_params)
      @post.save
      flash[:notice] == "Edit successfull: "
      redirect_to @post
    end
  end


  def destroy
    if current_user == @post.user
      @post.destroy
      flash[:notice] = "Sucessfully deleted the post:"
      redirect_to posts_path
    end
  end

  def upload_image
    render :json => FroalaEditorSDK::Image.upload(params)
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
    params.require(:post).permit(:title,:body,:tag_list)
  end
end
