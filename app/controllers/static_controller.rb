class StaticController < ApplicationController
  def index
    @posts = Post.order(created_at: :desc)
  end

  def about
    @recommended_posts = current_user.recommended_posts
  end

  def contact
  end
end
