require 'rails_helper'
require 'capybara/rails'

feature "Following" do

  before :each do
    user = create_user
    other_user = create_user({
                               username: 'test',
                               first_name: 'Bob',
                               last_name: 'Smith',
                               password: 'password',
                               bio: 'guy',
                               rant_frequency: 'Monthly'
                             })

    test_rant = "Rantly has allowed a certain freedom I never thought possible.
      Now I can rant to the internet at large, without having to worry
      about my thoughts. I just type it out, hit click, and feel
      the surge of relief. Thanks Rantly, you've truly made my most
      inane rants heard. I remember a time when I was able to truly express
      myself. It's really frustrating when you want to be heard and no one..."

    create_rant(other_user.id, subject: 'Other Stuff', body: test_rant)

    login(user)
  end

  scenario "user can follow and unfollow other users" do
    click_on "Follow"
    click_on "Following"
    expect(page).to have_content("Ian Knox", "Bob Smith Unfollow")
    click_on "Unfollow"
    expect(page).to have_content("Ian Knox")
    expect(page).to_not have_content("Bob Smith Unfollow")
  end
end