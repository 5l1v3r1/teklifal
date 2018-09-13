class User < ApplicationRecord
  include AASM
  include PgSearch
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  paginates_per 25

  pg_search_scope :search, :against => [:first_name, :last_name, :email, :phone]

  attr_accessor :signed_in_from_new_announcement, :creating_by_manager

  mount_uploader :avatar, AvatarUploader

  has_many :announcements, dependent: :destroy
  has_one :subscriber, foreign_key: :owner_id, inverse_of: :owner
  accepts_nested_attributes_for :subscriber
  has_many :offers, through: :subscriber, dependent: :destroy
  has_many :supervised_announcements,
            foreign_key: :supervisor_id,
            inverse_of: :supervisor,
            class_name: "Announcement"
  delegate :subscriptions, to: :subscriber

  validates_presence_of :first_name, :last_name, :phone
  validates_format_of :phone, with: /\A5[0-9]{9}\z/
  validates_uniqueness_of :phone

  aasm column: 'membership_status' do
    # kullanici kayit formunu doldurdu
    state :created_by_self, initial: true

    # manager tarafindan olusturulan hesap parolaya sahip degil
    # cep telefonuna da sahip olmayabilir
    state :unowned

    # unowned hesap kullanici tarafindan sahipligi alindi,
    # kullanici parolayi ve cep telefonu belirlemis olmali
    state :took_ownership

    # unowned hesap kendisi tarafindan istenilmedi:
    # kullanici mailine gonderilen link ile hesabini
    # kullanmak istemedi
    state :unowned_account_cancelled

    event :take_ownership do
      transitions from: :unowned, to: :took_ownership
    end

    event :cancel_by_self do
      transitions from: :unowned, to: :unowned_account_cancelled
    end
  end

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

  def creating_by_manager?
    @creating_by_manager
  end

  def self.lazy
    moderator_ids = select(:id).where(role: :moderator).pluck(:id)
    supervisor_group = Announcement.supervisors.count
    supervisor_ids = supervisor_group.keys
    user_id = ((moderator_ids-supervisor_ids).try(:first) or supervisor_ids.first)
    find user_id
  end

end
