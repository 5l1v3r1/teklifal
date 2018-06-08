class AddSupervisorToAnnouncements < ActiveRecord::Migration[5.2]
  def change
    add_column :announcements, :supervisor_id, :integer
  end
end
