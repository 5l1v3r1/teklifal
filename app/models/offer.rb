class Offer < ApplicationRecord
  include AASM
  belongs_to :user
  belongs_to :announcement
  has_many :attachments, as: :attachmentable
  accepts_nested_attributes_for :attachments, allow_destroy: true
  validates_presence_of :desc, :state, :announcement_id
  validate :validate_user_offer_count

  aasm column: 'state' do
    state :draft, initial: true
    state :published

    event :publish do
      transitions from: :draft, to: :published
    end
  end

  def owner? user
    self.user == user
  end

  def validate_user_offer_count
    if new_record? and announcement.offers.exists?(user: user)
      errors.add(:base, :number_of_offers_exceeded, message: I18n.t('errors.number_of_offers_exceeded'))
     end
  end

  def active?
    published? and announcement.published?
  end
end
