class HouseholdAppliancesAnnouncement < ApplicationRecord

  BRANDS = [].freeze

  has_one :announcement, as: :content, autosave: true, required: true, dependent: :destroy
  accepts_nested_attributes_for :announcement

  validates_presence_of :make
  validates_inclusion_of :make, in: BRANDS

end
