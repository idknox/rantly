require 'rails_helper'
require 'capybara/rails'

feature "Following" do

  before :each do
    @me = create_user
    @other_user = create_user(
      {username: 'test', first_name: 'Bob', last_name: 'Smith', password: 'password', bio: 'guy', rant_frequency: 'Monthly'}
    )
    @rant = create_rant(@other_user.id, subject: 'Other Stuff')
    login(@me)
  end

  scenario "User can follow and unfollow another from dashboard" do
    click_on "Follow"
    click_on "Following"
    expect(page).to have_content(full_name(@me), "#{full_name(@other_user)} Unfollow")

    visit root_path
    click_on "Unfollow"
    expect(page).to_not have_content(full_name(@other_user), @other_user.bio, "Unfollow")
  end

  scenario "User can follow and unfollow another via profile page" do
    click_on @other_user.first_name
    click_on "Follow"
    click_on "Following"
    expect(page).to have_content(full_name(@other_user), @other_user.bio, "Unfollow")

    visit user_path(@other_user)
    click_on "Unfollow"
    click_on "Following"
    expect(page).to_not have_content(full_name(@other_user), @other_user.bio, "Unfollow")
  end

  scenario "User can unfollow a user from Following page" do
    click_on @other_user.first_name
    click_on "Follow"
    click_on "Following"
    expect(page).to have_content(full_name(@other_user), @other_user.bio, "Unfollow")

    click_on "Unfollow"
    click_on "Following"
    expect(page).to_not have_content(full_name(@other_user), @other_user.bio, "Unfollow")
  end

end