require 'matrix'
require 'tf-idf-similarity'

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post , only: [:show,:destroy,:update,:edit,:upvote,:downvote]
  # before_action :get_username,except: [:create,:destroy,:update,:edit]

  def index
    @posts = Post.order(created_at: :desc)
    render formats: [ :html, :json]
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    # if verify_recaptcha(model: @post) && @post.save
    #   flash[:notice] = "Your post was succesfully submitted."
    #   redirect_to root_path
    # else
    #   flash[:notice] = "Invalid Captcha"
    #   redirect_to :back
    # end
    #@post.set_state
    if @post.save!
      flash[:notice] = "Your post was successfully submitted."
      redirect_to posts_path
    else
      flash[:notice] = "Invalid On Something"
      # maybe ignore the depreciation like redirect_back(fallback_location: fallback_location)
      redirect_to :back
    end
  end

  def show
    @comments = @post.comments
    @comment = Comment.new
    @comment.post_id = @post.id
    @comment.user_id = current_user.id
    # for recommendation system
    # working with recommendation system
    all_posts = []
    #binding.pry
    Post.all.each { |row | all_posts << row["body"] }
    all_posts_id = []
    Post.all.each {|row| all_posts_id << row["id"] }
    corpus = []
    for x in all_posts do
      corpus << TfIdfSimilarity::Document.new(x)
    end
    # finding current item in the corpus
    # current_body_from_corpus_id = 0
    # for i in 0..(corpus.length.to_i) do
    #   if @post.body === corpus[i].text
    #     current_post_from_corpus_id = i 
    #   end
    # end
    model = TfIdfSimilarity::TfIdfModel.new(corpus)
    matrix = model.similarity_matrix
    @similarity_hash = Hash.new
    new_matrix = matrix.to_a
    user_information = {}
    i = 0
    all_posts_id.each do |x|
      user_information[x] = i
      i = i+1
    end
    # indexing all the users in the database to the items in the model
    index_of_current_post = user_information[@post.id]
    current_post_similarity_matrix = new_matrix[index_of_current_post]
    for i in 0..(current_post_similarity_matrix.length.to_i-1) do
      @similarity_hash["#{all_posts_id[i]}".to_i] = current_post_similarity_matrix[i]
    end
    
    #binding.pry
    
    # for i in 0..(corpus.length.to_i-1) do
    #   # @similars = " " + all_posts[2].truncate(20) + " and " + all_posts[i].truncate(20) + " is "
    #   # @similarity_value = matrix[model.document_index(corpus[1]),model.document_index(corpus[i])]
    #   # current_post_id_in_corpus = corpus.index[current_post_body]
    #   @similarity_hash["#{all_posts_id[i]}".to_i] = matrix[model.document_index(corpus[]),model.document_index(corpus[i])]
    # end
    # # process of finding similarity based on posts
    # # arrange the similarity_hash on ascending order based on similarity score
    new_similarity_hash = @similarity_hash.sort_by {|key,value| -value }
    @perfect_hash = new_similarity_hash.to_h
    @similar_posts = []
    @perfect_hash.each do |key,value|
      @similar_posts << Post.find(key)
    end
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

  # def get_all_posts
  #   @posts = Post.all
  #   @username = User.find(user_id).username
  # end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title,:body,:tag_list)
  end
end
