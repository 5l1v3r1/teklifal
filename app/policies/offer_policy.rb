class OfferPolicy < ApplicationPolicy

  def index?
    signed_user
  end

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    signed_user and not record.announcement.offers.exists?(user: signed_user)    
  end

  def update?
    record.owner? signed_user
  end

  def edit?
    update?
  end
end