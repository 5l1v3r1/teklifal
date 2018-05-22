class Offer < ApplicationRecord
  belongs_to :user
  belongs_to :announcement
  has_many :attachments, as: :attachmentable
  accepts_nested_attributes_for :attachments, allow_destroy: true
end
