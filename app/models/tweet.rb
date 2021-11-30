class Tweet < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :likes,  dependent: :destroy

  validates_presence_of :tweet  
end
