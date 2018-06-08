class Announcement < ApplicationRecord
  DURATION_DAYS = [3, 10, 30]
  default_scope { where(archived: false) }
  has_many :offers, dependent: :destroy
  has_many :attachments, as: :attachmentable, dependent: :destroy
  accepts_nested_attributes_for :attachments, allow_destroy: true,
    reject_if: ->(attrs){ attrs[:file].blank? } 
  belongs_to :user
  belongs_to :supervisor, class_name: "User"
  scope :published, -> { where('expired_at > ?', Time.now) }
  scope :unpublished, -> { where('expired_at < ?', Time.now) }
  scope :archived, -> { unscoped.where(archived: true) }
  validates_presence_of :user, :title, :desc, :expired_at, :duration_day
  validates_inclusion_of :duration_day, in: DURATION_DAYS
  belongs_to :content, polymorphic: true, dependent: :destroy, optional: true, dependent: :destroy
  accepts_nested_attributes_for :content, allow_destroy: true

  def owner? user
    self.user == user
  end

  def duration_day= day
    self.expired_at = day.to_i.days.from_now
    super day
  end

  def published?
    # use try for initial nil expired_at value
    expired_at.try :>, Time.now
  end

  def expired?
    expired_at < Time.now
  end

  def expire!
    update_attribute :expired_at, Time.now
  end

  def archive!
    expire!
    update_attribute :archived, true
  end

  def content_type_name
    content_type.underscore if content_type
  end
end
