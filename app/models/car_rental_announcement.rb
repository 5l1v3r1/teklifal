require './lib/geocode_validator'

class CarRentalAnnouncement < ApplicationRecord
  has_one :announcement, as: :content, autosave: true, required: true, dependent: :destroy
  accepts_nested_attributes_for :announcement

  validates :pick_up_location, geocode: true, presence: true
  validates :drop_off_location, geocode: true, presence: true, 
            if: :different_location?

  validate :drop_off_time_must_be_greater_than_pick_up_time

  before_validation :empty_drop_off_location!, unless: :different_location?

  private

  def empty_drop_off_location!
    self.drop_off_location = nil
  end

  def drop_off_time_must_be_greater_than_pick_up_time
    errors.add(:drop_off_time, :smaller_than_pick_up_time) if pick_up_time >= drop_off_time
  end
end
