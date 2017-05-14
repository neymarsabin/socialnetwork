class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment].permit(:body))
    @comment.user_id = current_user.id
    @comment.save
    
    if @comment.save
      redirect_to post_path(@post)
    else
      flash[:notice] = "Comment was not saved!!!"
      redirect_to post_path(@post)
    end
  end 
end
