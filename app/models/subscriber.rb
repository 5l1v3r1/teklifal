class Subscriber < ApplicationRecord

  belongs_to :owner, class_name: "User"
  enum type: [:person, :firm]

  def owner? user
    self.owner == user
  end

end
