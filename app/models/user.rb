class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :signed_in_from_new_announcement

  mount_uploader :avatar, AvatarUploader

  has_many :announcements, dependent: :destroy
  has_one :subscriber, foreign_key: :owner_id, inverse_of: :owner
  has_many :offers, through: :subscriber, dependent: :destroy
  has_many :supervised_announcements,
            foreign_key: :supervisor_id,
            inverse_of: :supervisor,
            class_name: "Announcement"

  validates_presence_of :first_name, :last_name, :phone
  validates_format_of :phone, with: /\A5[0-9]{9}\z/
  validates_uniqueness_of :phone

  enum role: {
    registered: 0,
    moderator: 50,
    superadmin: 100
  }

  def <=> other_user
    self.class.roles[role] <=> self.class.roles[other_user.role]
  end

  def name
    first_name + ' ' + last_name
  end

  def offer_for state, announcement
    announcement.offers.find_by state: state, subscriber: subscriber
  end

  def manager?
    moderator? or superadmin?
  end

  def self.lazy
    moderator_ids = select(:id).where(role: :moderator).pluck(:id)
    supervisor_group = Announcement.supervisors.count
    supervisor_ids = supervisor_group.keys
    user_id = ((moderator_ids-supervisor_ids).try(:first) or supervisor_ids.first)
    find user_id
  end
end
