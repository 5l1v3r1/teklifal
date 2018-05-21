class Offer < ApplicationRecord
  belongs_to :announcement
  has_many :attachments, as: :attachmentable
end
