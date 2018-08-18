class Subscription < ApplicationRecord
  @@subclasses = []

  belongs_to :subscriber
  delegate :owner, to: :subscriber

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
