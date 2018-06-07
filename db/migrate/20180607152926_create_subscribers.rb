class CreateSubscribers < ActiveRecord::Migration[5.2]
  def change
    create_table :subscribers do |t|
      t.string :title
      t.integer :type
      t.integer :owner_id

      t.timestamps
    end

    add_index :subscribers, :owner_id
  end
end
