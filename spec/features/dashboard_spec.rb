require 'rails_helper'
require 'capybara/rails'

feature "Rants" do

  before :each do
    user = create_user
    create_rant(user.id)
    login(user)
  end

  scenario "User can create and delete a new Rant" do
    test_rant = "Rantly has allowed a certain freedom I never thought possible.
      Now I can rant to the internet at large, without having to worry
      about my thoughts. I just type it out, hit click, and feel
      the surge of relief. Thanks Rantly, you've truly made my most
      inane rants heard. I remember a time when I was able to truly express
      myself. It's really frustrating when you want to be heard and no one..."

    expect(page).to have_content("Ian Knox", "My Rants Ian #{test_rant}")
    click_on "Delete"

    expect(page).to have_content("Ian Knox", "My Rants")
    expect(page).to_not have_content(test_rant)
  end

  scenario "User can see others' rants" do
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

    visit "/"
    expect(page).to have_content("Latest Rants Bob Follow #{test_rant}")
  end
end
