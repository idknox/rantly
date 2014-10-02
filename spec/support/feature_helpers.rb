module FeatureHelpers

  def login(user, password = "password")
    visit root_path
    click_on "Login"
    fill_in "Username", with: user.username
    fill_in "Password", with: password
    click_on "LOGIN"
  end

  def full_name(user)
    [user.first_name, user.last_name].join(" ")
  end
end