require 'rails_helper'

RSpec.feature "Tweet Features", type: :feature do
    context 'create new tweet' do 
        before(:each) do
            visit new_tweet_path 
        end
        scenario "should be successful" do 
            within('form') do
                fill_in('Tweeet', with: 'this is sample tweet ')
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
        before(:each) do
          visit edit_tweet_path(tweet)
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
        tweet= Tweet.create!(tweet:"sample tweet !")
        visit tweets_path
        accept_confirm do 
            expect { click_link "Destroy" }.to change(Tweet, :count).by(-1)
          end 
          expect(page).to have_content "Tweet was deleted successfully !"
      end
    end
end