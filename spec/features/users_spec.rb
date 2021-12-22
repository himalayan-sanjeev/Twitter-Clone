require 'rails_helper'


RSpec.feature "Users Features", type: :feature  do 

  context 'create new user' do
    before(:each) do
        # User.destroy_all
        visit new_user_registration_path 
        user = FactoryBot.create(:user)
    end

    scenario "should be successful" do
        within('form') do
            fill_in('Name', with: user.name)
            fill_in('Username', with: user.username)
            fill_in('Email', with: user.email)
            fill_in('Password', with: user.password)
            fill_in('Password confirm', with: user.password_confirmation)

        end
          click_button 'Sign up'
          expect(page).to have_content "Welcome! You have signed up successfully"

    end

    scenario "should fail" do 
        click_button 'Sign up'
        expect(page).to have_content "User creation failed ! Fields cann't be empty."
    end

    scenario "should fail" do 
      within('form') do
        fill_in('Email', with: user.username)
      end

      click_button 'Sign up'
      expect(page).to have_content "User creation failed ! Invalid Email !"
    end
  end 


  context 'create new session' do
    before(:each) do
        visit new_user_session_path 
        user = FactoryBot.create(:user)

    end

    scenario "should be successful" do
        within('form') do
            fill_in('Email', with: user.email)
            fill_in('Password', with: user.password)
          end
          click_button 'Log in'
          expect(page).to have_content "Signed in successfully !"
    end

    scenario "should fail" do 
        within('form') do
          fill_in('Email', with: '')
          fill_in('Password', with: '')
        end
        click_button 'Log in'
        expect(page).to have_content "Invalid Email or password."

    end
  end 





  # context 'update user' do
    # let!(:user) {User.create!(name: 'danphe software', username:"danphe#{rand(234)}", email:"danphe.software#{rand(1000)}111@gmail.com ",password: '12345678')}

  #   before(:each) do
  #       # User.destroy_all

  #       debugger
  #       visit edit_user_path(user)
  #   end

  #   scenario "should be successful" do 
  #       within('form') do
  #           fill_in('Name', with: 'danphe software')
  #           fill_in('Username', with: 'danphe1')
  #           fill_in('Email', with: 'danphe.software111@example.com')
  #           fill_in('Password', with: '12345678')
  #         end
  #         click_button 'Update User'
  #         expect(page).to have_content "User was updated successfully !"
  #   end

  #   scenario "should fail" do   
  #       within('form') do 
  #         fill_in('Name', with: ' ')
  #         fill_in('Username', with: '')
  #       end
  #       click_button 'Update User'
  #       expect(page).to have_content "User updation  failed, field cann't be blank  !"
  #   end
  # end

end