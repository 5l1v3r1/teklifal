class AddArchivedToAnnouncements < ActiveRecord::Migration[5.2]
  def change
    add_column :announcements, :archived, :boolean, default: false
    add_index :announcements, :archived
  end
end
