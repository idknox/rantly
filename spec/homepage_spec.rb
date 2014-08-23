require 'rails_helper'
require 'capybara/rails'

feature "Homepage" do
  scenario "When user is not logged in they see splash page" do
    visit "/"

    expect(page).to have_content "Rantly", "Let it all out", "Login", "Join"
  end
end