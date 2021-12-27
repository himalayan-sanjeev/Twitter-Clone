class LikesController < ApplicationController
  before_action :require_login
  before_action :find_tweet
  before_action :find_like, only: [:destroy]

    def create
      @liked = tweet.likes.find{|like| like.user_id == current_user.id} 					  

      if already_liked?
        flash[:notice] = "Cann't like more than once"
      else
        @tweet.likes.create(user_id:current_user.id)
      end
      redirect_to tweet_path(@tweet)
        # @like = current_user.likes.new(like_params) 
        
        # redirect_to @like.tweet
    end

    def destroy
      if !(already_liked?)
        flash[:notice] = "Cann't do unlike"
      else
        @like.destroy
      end
      redirect_to tweet_path(@tweet)
      # @like = current_user.likes.find(params[:id])
      # tweet = @like.tweet
      # @like.destroy

      # redirect_to tweet
    end

    private

    def find_tweet
      @tweet = Tweet.find_by(id: params[:id])
    end

    def already_liked?
      Like.where(user_id: current_user.id, tweet_id: params[:tweet_id]).exists?
    end

    def find_like
      @like = @tweet.likes.find(params[:id])
    end

    def like_params
      params.require(:like).permit(:tweet_id)
    end
end
