class CommentsController < ApplicationController
    # before_action :set_tweet  # :set_comment,
    before_action :authenticate_user!

    def new
      # @comment = current_user.comments.build
      # @comment=Comment.new(params[:content])
      @comment= Comment.new

    end

    def show
      @comment = Comment.find(params[:id])
      @tweet= Tweet.find(params[:tweet_id])
    end

    def edit 
      @tweet= Tweet.find(params[:tweet_id])
      @comment=@tweet.comments.find(params[:id])
    end 

    def update
      @comment = Comment.find(params[:id])
      @comment.update(comment_params)
      redirect_to tweet_path(@tweet)
    end

    def create
      @comment = Comment.create(comment_params)
      @comment.user = current_user
      @comment.tweet_id = tweet_id
  
      respond_to do |format|
        if @comment.save
          format.html { redirect_back(fallback_location: root_path) }
          format.json { render :show, status: :created, location: @comment }
        else
          format.html { redirect_back(fallback_location: root_path) }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
      redirect_to  tweet_comment_path(@tweet)
    end

    private

    def set_comment
      @comment = Comment.find(params[:id])
    end
  
    def tweet_id
      params[:tweet_id]
    end
  
    def comment_params
      params.require(:comment).permit(:content)
    end
end

