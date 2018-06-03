class CarRentalAnnouncement < ApplicationRecord
  has_one :announcement, as: :content, autosave: true, required: true, dependent: :destroy
  accepts_nested_attributes_for :announcement
end
