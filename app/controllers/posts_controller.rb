require 'ruby-tf-idf'
class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show,:destroy,:update,:edit,:like,:dislike]

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

    # for machine learning
    posts_all = Post.all
    posts_body =[]
    posts_all.each do |post|
      posts_body << post.body
    end
    limit = 7
    exclude_stop_words = false
    @t = RubyTfIdf::TfIdf.new(posts_body,limit,exclude_stop_words)
    @values_tfidf = @t.tf_idf
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


  def upvote
    @post.upvote_from current_user
    redirect_to :back
  end
  
  def dislike
    @post.downvote_from current_user
    redirect_to :back
  end


  # def recommendation
  #   limit = 5
  #   exclude_stop_words = false
  #   @t = RubyTfIdf::TfIdf.new(corpus,limit,exclude_stop_words)
  #   @values_tfidf = @t.tf_idf
  # end
  


  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title,:body,:tag_list)
  end

  # def find_posts_body
  #   @posts = Post.all
  #   @posts_body = []
  # end
end
