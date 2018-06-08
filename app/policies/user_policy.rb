class UserPolicy < ApplicationPolicy
  def offers?
    signed_user == record
  end

  def announcements?
    signed_user == record
  end

  def subscription?
    signed_user.subscriber
  end
end