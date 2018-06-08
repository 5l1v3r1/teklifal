class AddSubscriberToOffers < ActiveRecord::Migration[5.2]
  def change
    add_reference :offers, :subscriber, foreign_key: true
  end
end
