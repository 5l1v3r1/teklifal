class Announcement < ApplicationRecord
  has_many :offers
  has_many :attachments, as: :attachmentable
  accepts_nested_attributes_for :attachments, allow_destroy: true
  belongs_to :user

end
