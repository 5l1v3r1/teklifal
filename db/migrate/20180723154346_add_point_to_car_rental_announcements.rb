class AddPointToCarRentalAnnouncements < ActiveRecord::Migration[5.2]
  def change
    enable_extension :postgis
    add_column :car_rental_announcements, :point, :st_point, geographic: true
    add_index :car_rental_announcements, :point, using: :gist

  end
end
