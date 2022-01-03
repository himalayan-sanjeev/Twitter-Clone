class Comment < ApplicationRecord
  belongs_to :tweet, foreign_key: 'tweet_id'
  belongs_to :user, foreign_key: 'user_id'

  validates_presence_of :content  

  has_many_attached :images


end
