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

  private
    
    def comment_params
      params.require(:comment).permit(:body)
    end
end 
