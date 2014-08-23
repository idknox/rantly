require 'rails_helper'
require 'capybara/rails'

feature "User Registration" do
  scenario "user can view reg page" do
    visit "/"
    click_on "Join"

    expect(page).to have_content "Register", "Username", "Password", "Bio"
  end
end