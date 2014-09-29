def create_user(overrides = {})
  User.create!({
                 username: 'idknox',
                 first_name: 'Ian',
                 last_name: 'Knox',
                 password: 'password',
                 bio: 'Student',
                 rant_frequency: 'Daily'
               }.merge(overrides))
end

def create_rant(id, overrides = {})
  test_rant = "Rantly has allowed a certain freedom I never thought possible.
      Now I can rant to the internet at large, without having to worry
      about my thoughts. I just type it out, hit click, and feel
      the surge of relief. Thanks Rantly, you've truly made my most
      inane rants heard. I remember a time when I was able to truly express
      myself. It's really frustrating when you want to be heard and no one..."

  Rant.create!({
                 subject: 'Stuff',
                 body: test_rant,
                 user_id: id
               }.merge(overrides))
end