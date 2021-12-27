class CommentsController < ApplicationController
    before_action :set_comment, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]

    def new
      @comment= Comment.new
    end

    def create  
      @comment = Comment.new(comment_params)
      @comment.tweet_id = params[:tweet_id]
      @comment.user_id = current_user.id
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

    def show
      @comment = Comment.find params[:id]
      @tweet = @comment.tweet
    end

    def hide
      @comment = Comment.find(params[:id])
      @tweet= Tweet.find(params[:tweet_id])
    end

    def edit
      @tweet = Tweet.find(params[:tweet_id])
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

  def destroy
    @comment = Comment.find params[:id]
    @tweet = @comment.tweet
    respond_to do |format|
      if @comment.destroy
        format.html { redirect_to tweet_comments_path(@tweet), notice: "Comment was successfully destroyed." }
        format.json { head :no_content }
        format.js
      else
        redirect_to tweet_comments_path(@tweet)
      end
    end
  end

    private
    def set_comment
      @comment = Comment.find(params[:id])
    end
  
    def comment_params
      params.require(:comment).permit(:content)
    end
end
