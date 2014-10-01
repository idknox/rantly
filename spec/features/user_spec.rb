require 'rails_helper'
require 'capybara/rails'

feature "User Registration" do

  before :each do
    visit "/"
    click_on "Join"

    fill_in "Username", :with => "idknox"
    fill_in "Password", :with => "password"
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
    fill_in "Password", :with => "password"
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

    expect(page).to have_content "Login failed"

    fill_in "Username", :with => "idkno"
    fill_in "Password", :with => "password"
    click_on "LOGIN"

    fill_in "Username", :with => "idknox"
    fill_in "Password", :with => "password"
    click_on "LOGIN"

    expect(page).to have_content "Ian Knox"
  end

  scenario "Logged in user can logout" do
    click_on "Login"
    fill_in "Username", :with => "idknox"
    fill_in "Password", :with => "password"
    click_on "LOGIN"

    click_on "LOGOUT"

    expect(page).to have_content "Rantly", "Let it all out"
  end

  scenario "Logged in user can edit their profile" do
    click_on "Login"
    fill_in "Username", :with => "idknox"
    fill_in "Password", :with => "password"
    click_on "LOGIN"

    click_on "Ian Knox"

    fill_in "First name", :with => "bob"

    click_on "Update User"

    expect(page).to have_content "Dashboard", "Ian Knox"
  end

  scenario "User can view another's profile from dashboard" do
    user = create_user(username: "me")
    other_user = create_user(
      {username: 'test', first_name: 'Bob', last_name: 'Smith', password: 'password', bio: 'guy', rant_frequency: 'Monthly'}
    )
    rant = create_rant(other_user.id, subject: 'Other Stuff')
    login(user)

    click_on other_user.first_name
    expect(page).to have_content(other_user.first_name + " " + other_user.last_name, other_user.bio, rant)
  end

  scenario "User can view another's profile from rant page" do
    user = create_user(username: "me")
    other_user = create_user(
      {username: 'test', first_name: 'Bob', last_name: 'Smith', password: 'password', bio: 'guy', rant_frequency: 'Monthly'}
    )
    rant = create_rant(other_user.id, subject: 'Other Stuff')
    login(user)
    click_on rant.body
    click_on other_user.first_name
    expect(page).to have_content(other_user.first_name + " " + other_user.last_name, other_user.bio, rant)

  end
end