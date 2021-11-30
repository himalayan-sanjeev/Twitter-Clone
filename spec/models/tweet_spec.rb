require 'rails_helper'
# require_relative '../app/models/tweet.rb'


RSpec.describe Tweet, type: :model do
  subject{
    Tweet.new(id: 6, tweet: 'hello, world!',user_id: 3)
  }
  
  

  it 'is not valid without a tweet' do 
    subject.tweet= nil 
    expect(subject).to_not be_valid 
  end

  it 'is not valid without a user id' do 
    subject.user_id= nil 
    expect(subject).to be_invalid 
  end

end
