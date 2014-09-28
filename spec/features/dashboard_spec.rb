require 'rails_helper'
require 'capybara/rails'

feature "Rants" do

  before :each do
    user = create_user
    create_rant(user.id)
    login(user)
  end

  scenario "User can create and delete a new Rant" do
    expect(page).to have_content("Ian Knox", "My Rants Ian blah blah blah")

    click_on "Delete"

    expect(page).to have_content("Ian Knox", "My Rants")
    expect(page).to_not have_content("blah blah blah")
  end

  scenario "User can see others' rants" do
    other_user = create_user(
      {
        username: 'test',
        first_name: 'Bob',
        last_name: 'Smith',
        password: 'password',
        bio: 'guy',
        rant_frequency: 'Monthly'
      }
    )
    create_rant(other_user.id, subject: 'Other Stuff', body: 'more blah')

    expect(page).to have_content("Latest Rants Bob more blah")
  end
end
