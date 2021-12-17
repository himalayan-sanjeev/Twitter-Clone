require 'rails_helper'


RSpec.feature "Users Features", type: :feature  do 
  context 'create new user' do
    before(:each) do
        visit new_user_registration_path 
    end

    scenario "should be successful" do
        within('form') do
            fill_in('Name', with: 'danphe software')
            fill_in('Username', with: 'danphe1')
            fill_in('Email', with: 'danphe.software@example.com')
            fill_in('user_password', with: '12345678')
            fill_in('user_password_confirmation', with: '12345678')
          end
          click_button 'Sign up'
          expect(page).to have_content "Welcome! You have signed up successfully"
    end

    scenario "should fail" do 
        click_button 'Sign up'
        expect(page).to have_content "User creation failed !"

    end
  end 

  
  context 'create new session' do
    before(:each) do
        visit new_user_session_path 
    end

    scenario "should be successful" do
        within('form') do
            fill_in('Email', with: 'danphe.software@example.com')
            fill_in('user_password', with: '12345678')
          end
          click_button 'Log in'
          expect(page).to have_content "Signed in successfully !"
    end

    scenario "should fail" do 
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