class ProfileController < ApplicationController
  def index
    @user= current_user
    @tweets = @user.tweets.all.order("created_at DESC")
    @tweet = Tweet.new 
  end

end