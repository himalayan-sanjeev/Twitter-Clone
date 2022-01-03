class TweetsController < ApplicationController

  before_action :set_tweet, only: [:show, :edit, :update, :destroy ]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /tweets or /tweets.json
  def index
    @tweets = Tweet.all.order("created_at DESC")
    @tweet = Tweet.new 
    @comments= @tweet.comments
    @users = User.all
    # @users = User.where.not(id: current_user.id).limit(10)
    # @comment = current_user.comments.build
  end

  # GET /tweets/1 or /tweets/1.json
  def show
    # debugger
    @comment = Comment.new
    @comment.tweet_id = @tweet.id
    @comment.user_id = current_user.id
    # @tweet= Tweet.find(params[:id])
    # @comments= @tweet.comments.all

    # @comments= Comment.where(tweet_id: @tweet).order("created_at DESC")
  end

  # GET /tweets/new
  def new
    @tweet = current_user.tweets.build
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets or /tweets.json
  def create
    @tweet = current_user.tweets.build(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to root_path, notice: "Tweet was successfully created." }
        format.json { render :show, status: :created, location: @tweet }
        format.js
      else
        
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1 or /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: "Tweet was successfully updated." }
        format.json { render :show, status: :ok, location: @tweet }
        format.js
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1 or /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: "Tweet was successfully destroyed." }
      format.json { head :no_content }
      format.js
    end
  end

  def like
    @tweet = Tweet.all.find(params[:id])
    Like.create(user_id: current_user.id, tweet_id:@tweet.id)
    redirect_to tweet_path(@tweet)
  end

  def toggle_hidden
    @comment.toggle!(:hidden)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:tweet,images:[])
    end
end


