require 'rails_helper'
require 'capybara/rails'

feature "Rants" do


  scenario "User can create and delete a new Rant" do
    user = create_user
    rant = create_rant(user.id)
    login(user)
    expect(page).to have_content("Ian Knox", "My Rants Ian #{rant.body}")
    click_on "Delete"

    expect(page).to have_content("Ian Knox", "My Rants")
    expect(page).to_not have_content(rant.body)
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

    rant = create_rant(other_user.id, subject: 'Other Stuff')

    user = create_user
    login(user)
    expect(page).to have_content("Latest Rants Bob", " #{rant.body}")
  end
end
