class Offer < ApplicationRecord
  include AASM
  belongs_to :subscriber
  delegate :user, to: :subscriber
  belongs_to :announcement
  has_many :attachments, as: :attachmentable, dependent: :destroy
  accepts_nested_attributes_for :attachments, allow_destroy: true
  validates_presence_of :desc, :state, :announcement_id, :subscriber
  validate :validate_user_offer_count
  scope :state, ->(state) { where(state: state) }
  scope :publishing, -> { joins(:announcement).where("announcements.expired_at > ?", Time.now) }

  aasm column: 'state' do
    state :draft, initial: true
    state :published

    event :publish do
      transitions from: :draft, to: :published
    end
  end

  def owner? user
    subscriber.user == user
  end

  def validate_user_offer_count
    if new_record? and announcement.offers.exists?(subscriber: subscriber)
      errors.add(:base, :number_of_offers_exceeded, message: I18n.t('errors.number_of_offers_exceeded'))
     end
  end

  def active?
    published? and announcement.published?
  end
end
