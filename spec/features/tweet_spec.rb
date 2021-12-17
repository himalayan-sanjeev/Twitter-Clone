require 'rails_helper'

RSpec.feature "Tweet Features", type: :feature do
    context 'create new tweet' do 
        let(:user) {User.create!(name: 'sanjeev', username:"sanjeev#{rand(12)}", email:"sanjeev111222#{rand(12)}@gmail.com ",password: '12345678')}

        before(:each) do
            visit new_user_session_path
            # user= User.create(name: 'sanjeev', username:'sanjeev12', email:"sanjeev111222333@gmail.com ",encrypted_password: '12345678')

            fill_in('Email', with: user.email)
            fill_in('Password', with: user.password)
            # fill_in('Password',visible: false, :with => user.encrypted_password)

    
            click_on("Log in")
        end

        scenario "should be successful" do 
            visit new_tweet_path 

            # within('form') do
                fill_in('tweet', with: 'this is sample tweet ')

            # end
            click_button 'Create Tweet'
            expect(page).to have_content "Tweet was posted successfully !"
        end

        scenario "should fail" do
            # within('form') do
                fill_in('tweet', with: ' ')
            # end
            click_button 'Create Tweet'
            expect(page).to have_content "Tweet creation failed, Tweet text must  be filled !"
        end 
    end

    context 'update tweet' do 
        let(:user) {User.create!(name: 'sanjeev', username:"sanjeev#{rand(12)}", email:"sanjeev111222#{rand(12)}@gmail.com ",password: '12345678')}
        let(:tweet) {Tweet.create!(id: 6,user: user, tweet:"this is sample tweet")}

        before(:each) do
              visit edit_tweet_path(tweet)
            end 
        end

        scenario "should be successful" do 
            # within('form') do
              fill_in('tweet', with: 'this is sample tweet')
            # end

            click_button 'Update Tweet'
            expect(page).to have_content "Tweet was edited successfully !"
        end

        scenario "should fail" do
            # within('form') do
              fill_in('tweet', with: '')
            # end
            click_button 'Update Tweet'
            expect(page).to have_content "Tweet field cannot be blank !!"
        end
    end

    context 'destroy tweet' do
      scenario "should be successful" do
        user=User.create!(name: 'sanjeev', username:"sanjeev#{rand(1234)}", email:"sanjeev111222#{rand(112233)}@gmail.com ",password: '12345678')
        tweet= Tweet.create!(user: user, tweet:"this is sample tweet")
        visit tweets_path
        accept_confirm do 
            click_link "Destroy"
          end 
          expect(page).to have_content "Tweet was deleted successfully !"
      
    end
end

