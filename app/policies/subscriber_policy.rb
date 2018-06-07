class SubscriberPolicy < ApplicationPolicy
  def new?
    create?
  end

  def create?
    signed_user
  end

  def edit?
    update?
  end

  def update?
    (signed_user and signed_user.manager?) or
    record.owner?(signed_user)
  end

  def destroy?
    update?
  end
end
