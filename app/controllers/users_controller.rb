class UsersController < ApplicationController
  def index
    @users = User.search(params[:search])
  end
  def show
    #@user = User.find_by_permalink(params[:id])
    find_user
    @posts = @user.posts.all
  end

  def my_friends
    @friendships = current_user.friends
    @friendships_inverse = current_user.inverse_friends
  end

  def add_friends
    @friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: @friend.id)
    if current_user.save
      redirect_to my_friends_path, notice:  "Friend was successfully followed"
    else
      redirect_to my_friends_path, flash[:error] = "There was an error with adding user as friend"
    end
  end

  private
  def find_user
    @user = User.find(params[:id])
  end
  
end
