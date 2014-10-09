module PeopleHelper

  def full_name(person)
    [person.first_name, person.last_name].join(" ")
  end

  def is_me?(user)
    user == current_user
  end

end
