class CommentsController < ApplicationController
    before_action :set_comment, :set_tweet
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

    def hide
      @comment = Comment.find(params[:id])
      @tweet= Tweet.find(params[:tweet_id])
    end

    def edit
      @tweet = Tweet.find(params[:tweet_id])
      # @comment=@tweet.comments.find(params[:id])
      @comment = Comment.find(params[:id])
    end

    def update
      @tweet= Tweet.find(params[:tweet_id])
      @comment = Comment.find(params[:id])
      respond_to do |format|
        if @comment.update(comment_params)
          format.html { redirect_to tweet_comment_path(@tweet), notice: "Comment was successfully updated." }
          format.json { render :show, status: :ok, location: @comment }
          format.js
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end
    
    def create
      @comment = Comment.create(comment_params)
      @comment.user = current_user
      @comment.tweet_id = tweet_id
  
      respond_to do |format|
        if @comment.save
          format.html { redirect_back(fallback_location: root_path) }
          format.json { render :show, status: :created, location: @comment }
          format.js
        else
          format.html { redirect_back(fallback_location: root_path) }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to tweet_comment_path(@tweet), notice: "Comment was successfully destroyed." }
        format.json { head :no_content }
        format.js
      end
    end

    private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_tweet
      @tweet = Tweet.find(params[:tweet_id])
    end
  
    # def tweet_id
    #   params[:tweet_id]
    # end
  
    def comment_params
      params.require(:comment).permit(:content)
    end
end

