class Subscription < ApplicationRecord
  @@subclasses = []

  belongs_to :subscriber
  delegate :owner, to: :subscriber


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
end
