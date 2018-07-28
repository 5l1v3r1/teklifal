class AddMembershipStatusToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :membership_status, :string

    User.all.each do |u|
      if u.encrypted_password.blank?
        u.update_attribute 'membership_status', "unowned"
      else
        u.update_attribute 'membership_status', "created_by_self"
      end
    end
  end

  def down
    remove_column :users, :membership_status
  end
end
