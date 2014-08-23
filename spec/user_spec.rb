require 'rails_helper'
require 'capybara/rails'

feature "User Registration" do
  scenario "user can view reg page" do
    visit "/"
    click_on "Join"

    expect(page).to have_content "Register", "Username", "Password", "Bio"
  end

  scenario "user must fill out entire form to register" do
    visit "/"
    click_on "Join"

    fill_in "Username", :with => "idknox"
    fill_in "Password", :with => "123"
    fill_in "First name", :with => "Ian"
    fill_in "Last name", :with => "Knox"
    fill_in "Bio", :with => "Student"
    click_on "Register"

    expect(page).to have_content "Post frequency can't be blank"
  end
end