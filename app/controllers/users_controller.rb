class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets
  end

  def following

  end

  def follow

  end

  def unfollow

  end
end