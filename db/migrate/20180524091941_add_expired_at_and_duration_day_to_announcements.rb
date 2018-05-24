class AddExpiredAtAndDurationDayToAnnouncements < ActiveRecord::Migration[5.2]
  def change
    add_column :announcements, :expired_at, :datetime
    add_column :announcements, :duration_day, :integer
  end
end
