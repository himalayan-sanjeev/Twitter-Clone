class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user

  def create
    # @user = User.find(user_id)
    current_user.follow(@user)
    redirect_to root_path
  end

  def destroy
    # @user = Relationship.find(id).followed
    current_user.unfollow(@user)
    redirect_to  root_path
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  # def id
  #   params[:id]
  # end

end

