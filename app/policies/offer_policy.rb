class OfferPolicy < ApplicationPolicy

  def show?
    (signed_user and signed_user.manager?) or 
    record.owner?(signed_user) or
    (record.announcement.user == signed_user)
  end

  def new?
    create?
  end

  def create?
    (signed_user and signed_user.manager?) or
    ( 
      signed_user and not record.announcement.offers.exists?(user: signed_user) and not 
      (record.announcement.user == signed_user)
    )
  end

  def update?
    signed_user and
    (
      signed_user.manager? or
      record.owner?(signed_user)
    )
  end

  def edit?
    update?
  end
end