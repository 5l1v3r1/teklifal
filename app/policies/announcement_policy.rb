class AnnouncementPolicy < ApplicationPolicy
  def show?
    true
  end

  def new?
    create?
  end

  def plain?
    create?
  end

  def create?
    true
  end

  def edit?
    update?
  end

  def update?
    (signed_user and signed_user.manager?) or
    record.owner?(signed_user)
  end

  def new_offer?
    signed_user and
    signed_user.subscriber and
    !record.offers.exists?(subscriber: signed_user.subscriber) and
    record.user != signed_user and
    record.published?
  end

  def destroy?
    update?
  end

  def expire?
    update?
  end
end