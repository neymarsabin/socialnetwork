class UsersController < ApplicationController
  def index
    @users = User.search(params[:search])
  end
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all
  end
end
