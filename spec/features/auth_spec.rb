require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit(new_user_url)
    expect(page).to have_content("Sign Up")
  end

  feature "signing up a user" do

    before(:each) do
      visit new_user_url
      fill_in 'Username', :with => "testing_username"
      fill_in 'Password', :with => "biscuits"
      click_on "Create User"
    end

    scenario "shows username on the homepage after signup" do
      expect(page).to have_content("testing_username")
    end

  end

end

feature "logging in" do

  before(:each) do
    visit new_user_url
    fill_in 'Username', :with => "testing_username"
    fill_in 'Password', :with => "biscuits"
    click_on "Create User"
    visit new_session_url
    fill_in 'Username', :with => "testing_username"
    fill_in 'Password', :with => "biscuits"
    click_on "Login"
  end

  scenario "shows username on the homepage after login" do
    expect(page).to have_content("testing_username")
  end

end

feature "logging out" do

  scenario "begins with a logged out state" do
    visit new_session_url
    expect(page).to_not have_content("Logout")
  end

  scenario "doesn't show username on the homepage after logout" do
    visit new_user_url
    fill_in 'Username', :with => "testing_username"
    fill_in 'Password', :with => "biscuits"
    click_on "Create User"
    visit new_session_url
    fill_in 'Username', :with => "testing_username"
    fill_in 'Password', :with => "biscuits"
    click_on "Login"

    click_on "Logout"

    expect(page).to_not have_content("testing_username")
  end

end
