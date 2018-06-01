class UserPolicy < ApplicationPolicy
  def offers?
    signed_user == record
  end

  def announcements?
    signed_user == record
  end
end