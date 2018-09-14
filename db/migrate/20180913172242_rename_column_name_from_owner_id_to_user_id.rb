class RenameColumnNameFromOwnerIdToUserId < ActiveRecord::Migration[5.2]
  def change
    rename_column(:subscribers, :owner_id, :user_id)
  end
end
