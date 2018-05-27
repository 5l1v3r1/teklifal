class AddContentToAnnouncements < ActiveRecord::Migration[5.2]
  def change
    add_reference :announcements, :content, polymorphic: true
  end
end
