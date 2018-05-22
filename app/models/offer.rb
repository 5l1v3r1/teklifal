class Offer < ApplicationRecord
  belongs_to :user
  belongs_to :announcement
  has_many :attachments, as: :attachmentable
  accepts_nested_attributes_for :attachments, allow_destroy: true

  def owner? user
    self.user == user
  end
end
