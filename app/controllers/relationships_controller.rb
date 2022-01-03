class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user

  # def index
  #   @active_relationships = current_user.active_relationships
  #   @passive_relationships = current_user.passive_relationships
  # end

  def create
    other_user = User.find(params[:user_id])
    @relation = Relationship.new(follower_id:current_user.id, following_id:other_user.id)
    @relation.save
    redirect_to user_path(other_user)


    # @followed_user = User.find(params[:relationship][:followed_id])
    # @relationship = current_user.active_relationships.new(followed_id: @followed_user.id)
    # if @relationship.save
    #   redirect_to user_path(@followed_user)
    # end
  end

  def destroy
    @relation = Relationship.find(params[:id])
    @relation.destroy
    redirect_to user_path(@relation.followed_id)
  end  
  
  private
  def find_user
    @user = User.find(params[:user_id])
  end

end
