require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  scenario "has a new user page" do
    visit new_user_url

    expect(page).to have_content("Sign Up")
  end

  feature "signing up a user" do
    scenario "shows username on the homepage after signup" do
      visit new_user_url
      user = FactoryGirl.build(:user)
      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_on "Sign Up"

      expect(page).to have_content(user.username)
    end

    scenario "verifies required attributes" do
      expect(FactoryGirl.build(:user)).to be_valid
    end
  end

  feature "logging in" do
    scenario "shows username on the homepage after login" do
      visit new_session_url
      user = FactoryGirl.create(:user)
      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_on "Log In"

      expect(page).to have_content(user.username)
    end
  end

  feature "logging out" do
    scenario "begins with logged out state" do
      visit goals_url
      expect(page).to_not have_content("Add Goal")
      click_on "Log In"
      expect(current_path).to eq(new_session_path)
    end

    scenario "doesn't show username on the homepage after logout" do
      visit new_session_url
      user = FactoryGirl.create(:user)
      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_on "Log In"
      click_on "Log Out"

      expect(page).to_not have_content(user.username)
    end
  end
end
