require 'rails_helper'
require 'capybara/rails'

feature "Following" do

  before :each do
    user = create_user
    @other_user = create_user({
                               username: 'test',
                               first_name: 'Bob',
                               last_name: 'Smith',
                               password: 'password',
                               bio: 'guy',
                               rant_frequency: 'Monthly'
                             })

    create_rant(@other_user.id, subject: 'Other Stuff')

    login(user)
  end

  scenario "user can follow and unfollow other users from following page" do
    click_on "Follow"
    click_on "Following"
    expect(page).to have_content("Ian Knox", "Bob Smith Unfollow")
    click_on "Unfollow"
    expect(page).to have_content("Ian Knox")
    expect(page).to_not have_content("Bob Smith Unfollow")
  end

  scenario "user can follow and unfollow other users from dashboard" do
    click_on "Follow"
    click_on "Unfollow"
  end

  scenario "user can follow another via profile page" do
    click_on @other_user.first_name
    click_on "Follow"
    click_on "Following"
    expect(page).to have_content("Ian Knox", "Bob Smith Unfollow")
    visit user_path(@other_user.id)
    click_on "Unfollow"
    expect(page).to_not have_content("Bob Smith Unfollow")
  end
end