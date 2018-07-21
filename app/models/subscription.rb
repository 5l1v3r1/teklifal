class Subscription < ApplicationRecord
  belongs_to :subscriber

  def owner? user
    self.user == user
  end
end
