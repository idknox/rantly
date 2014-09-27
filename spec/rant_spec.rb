require 'rails_helper'
require 'capybara/rails'

feature "Rants" do

  before :each do
    visit "/"
    click_on "Join"

    fill_in "Username", with: "idknox"
    fill_in "Password", with: "123"
    fill_in "First name", with: "Ian"
    fill_in "Last name", with: "Knox"
    fill_in "Bio", with: "Student"
    within ".frequency-container" do
      choose "Daily"
    end
    click_on "Create User"
    click_on "Login"
    fill_in "Username", with: "idknox"
    fill_in "Password", with: "123"
    click_on "LOGIN"
  end

  scenario "User can create a new Rant" do
    fill_in "A rant about:", with: "Stuff"
    fill_in "Rant", with: "blah blah blah"
    click_on "RANT"
    expect(page).to have_content("Ian Knox", "My Rants Ian blah blah blah")
  end
end
