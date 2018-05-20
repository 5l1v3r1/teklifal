class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|
      t.references :announcement, foreign_key: true
      t.text :desc

      t.timestamps
    end
  end
end
