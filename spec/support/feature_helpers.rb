module FeatureHelpers

  def login(user, password = "password")
    visit root_path
    click_on "Login"
    fill_in "Username", with: user.username
    fill_in "Password", with: password
    click_on "LOGIN"
  end

end