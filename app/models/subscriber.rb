class Subscriber < ApplicationRecord
  belongs_to :user
  has_many :offers
  has_many :subscriptions, dependent: :destroy
  enum subscriber_type: [:person, :firm]
  validates_presence_of :title, :user, :subscriber_type

  def owner? user
    self.user == user
  end

  def screen_name
    title || user.name
  end

end
