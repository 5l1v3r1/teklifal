class CreateHouseholdAppliancesAnnouncements < ActiveRecord::Migration[5.2]
  def change
    create_table :household_appliances_announcements do |t|
      t.string :make

      t.timestamps
    end
  end
end
