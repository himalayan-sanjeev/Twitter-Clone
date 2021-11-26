class LikesController < ApplicationController
    def create
        @like = current_user.likes.new(like_params) 
        
        redirect_to @like.tweet
    end

    def destroy
      @like = current_user.likes.find(params[:id])
      tweet = @like.tweet
      @like.destroy

      redirect_to tweet
    end

    private
    def like_params
      params.require(:like).permit(:tweet_id)
    end
end
