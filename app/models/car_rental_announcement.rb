require './lib/geocode_validator'

class CarRentalAnnouncement < ApplicationRecord
  has_one :announcement, as: :content, autosave: true, required: true, dependent: :destroy
  accepts_nested_attributes_for :announcement

  validates :pick_up_location, geocode: true, presence: true
  validates :drop_off_location, geocode: true, presence: true, 
            if: :different_location?

  before_validation :empty_drop_off_location!, unless: :different_location?

  private

  def empty_drop_off_location!
    self.drop_off_location = nil
  end
end
