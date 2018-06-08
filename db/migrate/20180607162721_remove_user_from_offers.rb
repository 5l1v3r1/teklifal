class RemoveUserFromOffers < ActiveRecord::Migration[5.2]
  def change
    remove_reference :offers, :user, foreign_key: true
  end
end
