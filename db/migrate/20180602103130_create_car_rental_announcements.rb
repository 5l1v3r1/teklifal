class CreateCarRentalAnnouncements < ActiveRecord::Migration[5.2]
  def change
    create_table :car_rental_announcements do |t|
      t.string :pick_up_location
      t.string :drop_off_location
      t.boolean :different_location
      t.datetime :pick_up_time
      t.datetime :drop_off_time

      t.timestamps
    end
  end
end
