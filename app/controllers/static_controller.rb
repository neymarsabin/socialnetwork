class StaticController < ApplicationController
  def index
    @posts = Post.order(created_at: :desc)
  end

  def about
  end

  def contact
  end
end
