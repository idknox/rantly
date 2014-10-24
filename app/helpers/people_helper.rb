module PeopleHelper

  def full_name(person)
    [person.first_name, person.last_name].join(" ")
  end

  def is_me?(user)
    user == current_user
  end

  def user_is_admin?(user)
    user.admin
  end
end
