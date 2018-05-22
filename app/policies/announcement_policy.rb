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
end