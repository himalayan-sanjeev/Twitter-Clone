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
            fill_in('Password', with: '12345678')
          end
          click_button 'Create User'
          expect(page).to have_content "User was created successfully !"
    end

    scenario "should fail" do 
        click_button 'Create User'
        expect(page).to have_content "User creation failed !"

    end
  end 


  context 'update user' do
    let!(:user) {User.create!(name: 'danphe software', username:'danphe1', email:"danphe.software111@gmail.com ",password: '12345678')}

    before(:each) do
        visit edit_user_path(user)
    end

    scenario "should be successful" do 
        within('form') do
            fill_in('Name', with: 'danphe software')
            fill_in('Username', with: 'danphe1')
            fill_in('Email', with: 'danphe.software111@example.com')
            fill_in('Password', with: '12345678')
          end
          click_button 'Update User'
          expect(page).to have_content "User was updated successfully !"
    end

    scenario "should fail" do   
        within('form') do 
          fill_in('Name', with: ' ')
          fill_in('Username', with: '')
        end
        click_button 'Update User'
        expect(page).to have_content "User updation  failed, field cann't be blank  !"
    end
  end

end