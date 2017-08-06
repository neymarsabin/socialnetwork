class StaticController < ApplicationController
  def index
    @posts = Post.order(created_at: :desc)
  end

  def about
    @recommended_posts = current_user.recommended_posts
  end

  def contact
    
  end

  def profile
    @posts = current_user.posts.all
    @questions = current_user.questions.all
    @following = current_user.friends
    @followers = current_user.inverse_friends
  end
  def settings
  end
end
