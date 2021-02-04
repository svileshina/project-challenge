class DogPolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    record.user == user
  end
end