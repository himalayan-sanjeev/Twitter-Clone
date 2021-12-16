require 'rails_helper'


RSpec.feature "Tweet Features", type: :feature do
    context 'create new tweet' do 
        before(:each) do
            user= User.create!(name: 'sanjeev', username:'sanjeev12', email:"sanjeev111222333@gmail.com ",encrypted_password: '12345678')
            login_as(user)
            visit new_tweet_path 
        end
        scenario "should be successful" do 
            within('form') do
                fill_in('Tweet', with: 'this is sample tweet ')

            end
            click_button 'Create Tweet'
            expect(page).to have_content "Tweet was posted successfully !"
        end

        scenario "should fail" do
            click_button 'Create Tweet'
            expect(page).to have_content "Tweet creation failed, Tweet text must  be filled !"
        end 
    end

    context 'update tweet' do 
        let!(:tweet) {Tweet.create!(id: 6,user_id: 3, tweet:"this is sample tweet")}

        before(:each) do
            if user_signed_in?
              visit edit_tweet_path(tweet)
            end 

            
        end

        scenario "should be successful" do 
            within('form') do
              fill_in('Tweet', with: 'this is sample tweet')
            end

            click_button 'Update Tweet'
            expect(page).to have_content "Tweet was edited successfully !"
        end

        scenario "should fail" do
            within('form') do
              fill_in('Tweet', with: '')
            end
            click_button 'Update Tweet'
            expect(page).to have_content "Tweet field cannot be blank !!"
        end
    end

    context 'destroy tweet' do
      scenario "should be successful" do
        let!(:tweet) {Tweet.create!(id: 6,user_id: 3, tweet:"this is sample tweet")}
        visit tweets_path
        accept_confirm do 
            click_link "Destroy"
          end 
          expect(page).to have_content "Tweet was deleted successfully !"
      end
    end
end