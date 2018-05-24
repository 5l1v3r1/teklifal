class AnnouncementPolicy < ApplicationPolicy
  def index?
    signed_user
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
    record.owner? signed_user
  end

  def new_offer?
    !record.offers.exists?(user: signed_user) and not record.user == signed_user
  end

  def destroy?
    update?
  end

  def expire?
    update?
  end
end