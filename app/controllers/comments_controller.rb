class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params[:comment].permit(:body))
    @comment.user_id = current_user.id
    if @comment.save
      @comment.create_activity :create,owner: current_user
      redirect_to post_path(@post)
    else
      flash[:notice] = "Comment was not saved!!!"
      redirect_to post_path(@post)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])
    if @comment.destroy
      flash[:notice] = "Comment sucessfully deleted!!"
      redirect_to post_path(@post)
    else
      flash[:notice] = "Cannot delete comment"
    end
  end
end
