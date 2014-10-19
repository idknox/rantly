require 'rails_helper'
require 'capybara/rails'

feature "Admin" do

  before :each do
    @me = create_user(admin: true)
    @other_user = create_user(
      {username: 'test', first_name: 'Bob', last_name: 'Smith', password: 'password', bio: 'guy', rant_frequency: 'Monthly'}
    )
    @rant = create_rant(@other_user.id, subject: 'Other Stuff')
    @rant_two = create_rant(@other_user.id, subject: 'More Stuff')
    @rant_three = create_rant(@other_user.id, subject: 'Even More Stuff')
    login(@me)
  end

  scenario "Admin can view all rants" do
    click_on 'Rants'
    expect(page).to have_content(
                      'All',
                      'Spam',
                      full_name(@other_user),
                      @rant.subject, @rant_two.subject,
                      @rant_three.subject
                    )
  end
end