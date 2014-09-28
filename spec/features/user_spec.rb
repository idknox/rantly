require 'rails_helper'
require 'capybara/rails'

feature "User Registration" do

  before :each do
    visit "/"
    click_on "Join"

    fill_in "Username", :with => "idknox"
    fill_in "Password", :with => "123"
    fill_in "First name", :with => "Ian"
    fill_in "Last name", :with => "Knox"
    fill_in "Bio", :with => "Student"
    within ".frequency-container" do
      choose "Daily"
    end
    click_on "Create User"
  end

  scenario "user can view reg page" do
    visit "/"
    click_on "Join"

    expect(page).to have_content "Register", "Username", "Password", "Bio"
  end

  scenario "user must fill out entire form to Create User" do
    visit "/"
    click_on "Join"

    fill_in "Username", :with => "idknox"
    fill_in "Password", :with => "123"
    fill_in "First name", :with => "Ian"
    fill_in "Last name", :with => "Knox"
    fill_in "Bio", :with => "Student"
    click_on "Create User"

    expect(page).to have_content "Rant frequency can't be blank"
  end

  scenario "User can Create User" do
    expect(page).to have_content "Thank you for registering!"
  end

  scenario "Registered user can log in" do
    click_on "Login"
    fill_in "Username", :with => "idknox"
    fill_in "Password", :with => "12"
    click_on "LOGIN"

    expect(page).to have_content "Username / password is invalid"

    fill_in "Password", :with => "123"
    click_on "LOGIN"

    expect(page).to have_content "Ian Knox"
  end

  scenario "Logged in user can logout" do
    click_on "Login"
    fill_in "Username", :with => "idknox"
    fill_in "Password", :with => "123"
    click_on "LOGIN"

    click_on "LOGOUT"

    expect(page).to have_content "Rantly", "Let it all out"
  end

  scenario "Logged in user can edit their profile" do
    click_on "Login"
    fill_in "Username", :with => "idknox"
    fill_in "Password", :with => "123"
    click_on "LOGIN"

    click_on "Ian Knox"

    fill_in "First name", :with => "bob"

    click_on "Update User"

    expect(page).to have_content "Dashboard", "Ian Knox"
  end
end