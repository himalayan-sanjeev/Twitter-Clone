require 'rails_helper'

RSpec.feature "Comment Features", type: :feature do

    context 'create new comment' do 
        let(:user) {User.create!(name: 'sanjeev', username:"sanjeev#{rand(11112)}", email:"sanjeev111222#{rand(1233)}@gmail.com ",password: '12345678')}
        let(:tweet) {Tweet.create!(id: 6,user: user, tweet:"this is sample tweet")}
        before(:each) do
            visit new_user_session_path
            fill_in('Email', with: user.email)
            fill_in('Password', with: user.password)    
            click_on("Log in")
        end
        
        scenario "should be successful" do 
            visit tweet_comments_path(tweet)

            within('form') do
                fill_in('content', with: 'this is sample comment ')
            end

            click_button 'Create Comment'
            expect(page).to have_content "Comment was posted successfully !"
        end

        scenario "should fail" do
            click_button 'Create Comment'
            expect(page).to have_content "comment creation failed, comment body must  be filled !"
        end 
    end

    context 'update comment' do 
        before(:each) do
          visit edit_tweet_comment_path(tweet)
        end

        scenario "should be successful" do 
            within('form') do
              fill_in('Comment', with: 'this is sample comment')
            end
            
            click_button 'Update Comment'
            expect(page).to have_content "Comment was edited successfully !"
        end

        scenario "should fail" do
            within('form') do
              fill_in('Comment', with: '')
            end
            click_button 'Update Comment'
            expect(page).to have_content "Comment field cannot be blank !!"
        end
    end

    context 'destroy comment' do
      scenario "should be successful" do
        comment= Comment.create!(user_id:3, tweet_id:3,content:"sample comment !")
        visit tweet_comments_path(tweet)
        accept_confirm do 
            click_link "Destroy"
        end 
          expect(page).to have_content "Comment was deleted successfully !"
      end
    end

end