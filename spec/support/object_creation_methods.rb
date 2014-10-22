def create_user(overrides = {})
  User.create!({
                 username: 'idknox',
                 first_name: 'Ian',
                 last_name: 'Knox',
                 email: 'fake@fake.com',
                 password: 'password',
                 bio: 'Student',
                 rant_frequency: 'Daily'
               }.merge(overrides))
end

def create_rant(id, overrides = {})
  test_rant = (0...145).map { (65 + rand(26)).chr }.join
  Rant.create!({
                 subject: 'Stuff',
                 body: test_rant,
                 user_id: id
               }.merge(overrides))
end