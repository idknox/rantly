require 'rails_helper'
require 'capybara/rails'

feature "Rants" do

  before :each do
    user = create_user
    other_user = create_user(
      {username: 'test', first_name: 'Bob', last_name: 'Smith', password: 'password', bio: 'guy', rant_frequency: 'Monthly'}
    )

    create_rant(other_user.id, subject: 'Other Stuff')

    login(user)
  end
end
