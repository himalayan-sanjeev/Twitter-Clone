class CommentsController < ApplicationController
    before_action :find_tweet
    #before_action :authenticate_user!
    def new
    end


    def show
    end

    def edit 
    end 


    def update 
    end


    def create
      @comment = @tweet.comments.create(params[:comment].permit(:content))
      # @comment= current_user.comments.new(comment_params)
      @comment.user_id= current_user.id
      @comment.save

      if @comment.save
        redirect_to tweet_path(@tweet)
      else
        render new
      end
    end

    def destroy
    end

    private

    def find_tweet
      @tweet = Tweet.find(params[:tweet_id])
    end
    
end
