require 'rails_helper'
require 'capybara/rails'

feature "Rants" do
  scenario "User can view another user's rant" do
    user = create_user
    other_user = create_user(
      {username: 'test', first_name: 'Bob', last_name: 'Smith', password: 'password', bio: 'guy', rant_frequency: 'Monthly'}
    )
    rant = create_rant(other_user.id, subject: 'Other Stuff')
    login(user)

    visit root_path

    click_on rant.body
    expect(page).to have_content(rant.subject, rant.body, "Favorite")
  end
end
