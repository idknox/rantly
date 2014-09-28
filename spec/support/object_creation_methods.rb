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
