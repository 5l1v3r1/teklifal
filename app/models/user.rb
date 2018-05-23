class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :announcements
  has_many :offers

  def name
    first_name + ' ' + last_name
  end

  def offer_for state, announcement
    announcement.offers.find_by state: state, user: self
  end
end
