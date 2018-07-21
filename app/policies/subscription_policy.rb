class SubscriptionPolicy < ApplicationPolicy

  def my?
    signed_user
  end

  def index?
    true
  end

  def show?
    signed_user and
    record.user == signed_user
  end

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
    signed_user and
    (
      signed_user.manager? or
      record.user == signed_user
    )
  end

  def destroy?
    update?
  end


  def permitted_attributes
    attributes.concat subscription_attrs
  end

  private

  def subscription_attrs
    [:type]
  end

  # Must be blank array for root content policy
  def attributes
    []
  end
end