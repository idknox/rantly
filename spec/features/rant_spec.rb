require 'rails_helper'
require 'capybara/rails'

feature "Rants" do

  before :each do
    user = create_user
    login(user)
  end

  scenario "User can create and delete a new Rant" do
    fill_in "A rant about:", with: "Stuff"
    fill_in "Rant", with: "blah blah blah"
    click_on "RANT"
    expect(page).to have_content("Ian Knox", "My Rants Ian blah blah blah")

    click_on "Delete"

    expect(page).to have_content("Ian Knox", "My Rants")
    expect(page).to_not have_content("blah blah blah")
  end

  scenario "User can see others' rants" do

  end
end
