class UsersController < ApplicationController
  def index
    #    @users = User.all
    @users = User.search(params[:search])
  end
end
