class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :announcements, dependent: :destroy
  has_many :offers, dependent: :destroy

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
    announcement.offers.find_by state: state, user: self
  end

  def manager?
    moderator? or superadmin?
  end
end
