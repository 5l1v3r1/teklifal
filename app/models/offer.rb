class Offer < ApplicationRecord
  belongs_to :user
  belongs_to :announcement
  has_many :attachments, as: :attachmentable
  accepts_nested_attributes_for :attachments, allow_destroy: true
  validate :validate_user_offer_count

  def owner? user
    self.user == user
  end

  def validate_user_offer_count
    if announcement.offers.exists?(user: user)
      errors.add(:base, :number_of_offers_exceeded, message: I18n.t('errors.number_of_offers_exceeded'))
     end
  end
end
