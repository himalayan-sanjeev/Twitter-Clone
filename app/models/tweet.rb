class Tweet < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :likes,  dependent: :destroy

  validates_presence_of :tweet

  has_many_attached :images
  # has_many_attached :videos

  
  def liked?(user)
    !!self.likes.find{|like| like.user_id == user.id }
  end
end
