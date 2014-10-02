require 'rails_helper'
require 'capybara/rails'

feature "Rants" do

  before :each do
    user = create_user
    @other_user = create_user(
      {username: 'test', first_name: 'Bob', last_name: 'Smith', password: 'password', bio: 'guy', rant_frequency: 'Monthly'}
    )
    @rant = create_rant(@other_user.id, subject: 'Other Stuff')
    login(user)
  end

  scenario "User can view another user's rant" do
    click_on @rant.body
    expect(page).to have_content(@rant.subject, @rant.body, "Favorite")
  end

  scenario "User can favorite a rant from rant page" do
    click_on @rant.body
    click_on "Favorite"
    expect(page).to have_content("Unfavorite")
    click_on "Favorites"
    expect(page).to have_content(@rant.body, @other_user.first_name, "Unfavorite")
  end

  scenario "User can favorite a rant from dashboard" do
    click_on "Favorite"
    expect(page).to have_content("Unfavorite")
    click_on "Favorites"
    expect(page).to have_content(@rant.body, @other_user.first_name, "Unfavorite")
  end

  scenario "user can favorite rants from profile page" do
    click_on @other_user.first_name
    click_on "Favorite"
    expect(page).to have_content("Unfavorite")
    click_on "Favorites"
    expect(page).to have_content(@rant.body, @other_user.first_name, "Unfavorite")
  end
end

