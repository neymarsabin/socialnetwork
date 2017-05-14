class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to post_path(@comment.post_id)
    else
      flash[:notice] = " Something's wrong in your comment.Please check!"
    end
  end
  
  def destroy
    @comment = current_user.comments.find_by(params[:comment])
    if @comment.destroy
      flash[:notice] = "Successfully deleted the comment"
      redirect_to post_path(@comment.post_id)
    else
      flash[:notice] = "Cannot deleted the comment"
    end
  end 

  def edit
    @post = Post.find_by(params[:post_id])
    @comment = @post.comments.find_by(params[:comment])
  end

  def update
    if @comment.save(comment_params)
      flash[:notice] = "Edit comment complete"
    else
      flash[:notice] = "Cannot edit comment"
    end
  end 

  
  private

  def comment_params
    params.require(:comment).permit(:post_id,:body)
  end
  
end 
