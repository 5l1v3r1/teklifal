class Subscriber < ApplicationRecord

  belongs_to :owner, class_name: "User"
  has_many :offers
  has_many :subscriptions, dependent: :destroy
  enum subscriber_type: [:person, :firm]
  validates_presence_of :title, :owner, :subscriber_type

  def owner? user
    self.owner == user
  end

  def screen_name
    title || user.name
  end

end
