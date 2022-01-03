class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :tweets, dependent: :destroy
  has_many :comments,  dependent: :destroy
  has_many :likes,  dependent: :destroy

  has_one_attached :profile_pic

  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'following_id', dependent: :destroy

  has_many :following, through: :active_relationships, source: :following
  has_many :followers, through: :passive_relationships, source: :follower


  # Following helper methods
  def follow(user)
    active_relationships.create(following_id: user.id)
  end

  def unfollow(user)
    active_relationships.find_by(following_id: user.id).destroy
  end

  def following?(user)
    following.include?(user)
  end

end
