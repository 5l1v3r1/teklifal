class Subscriber < ApplicationRecord

  belongs_to :owner, class_name: "User"
  has_many :offers
  enum subscriber_type: [:person, :firm]
  validates_presence_of :owner, :subscriber_type

  def owner? user
    self.owner == user
  end

  def screen_name
    title || user.name
  end

end
