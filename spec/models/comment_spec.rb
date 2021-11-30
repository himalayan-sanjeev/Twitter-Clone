require 'rails_helper'
# require_relative '../app/models/comment.rb'


RSpec.describe Comment, type: :model do
  subject{
    Comment.new(id: 6, content: 'hello, world!',user_id: 3)
  }
  
  # it 'is valid with valid attributes' do
  #   expect(subject).to be_valid
  # end

  it 'is not valid without a tweet' do 
    subject.content= nil 
    expect(subject).to_not be_valid 
  end

end
