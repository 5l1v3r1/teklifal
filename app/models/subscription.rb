class Subscription < ApplicationRecord
  paginates_per 25
  belongs_to :subscriber
  has_one :user, through: :subscriber


  validate :exists_same_filter


  def owner? user
    owner == user
  end

  def filter
    OpenStruct.new(super || {})
  end

  def self.subclasses
    [
      CarAnnouncementSubscription,
      CarRentalAnnouncementSubscription
    ]
  end

  private

  def exists_same_filter
    if subscriber.subscriptions.where(filter: self[:filter]).exists?
      errors.add(:filter, :taken)
    end
  end
end
