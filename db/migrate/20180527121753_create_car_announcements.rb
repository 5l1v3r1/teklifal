class CreateCarAnnouncements < ActiveRecord::Migration[5.2]
  def change
    create_table :car_announcements do |t|

      t.string :make

      t.timestamps
    end
  end
end
