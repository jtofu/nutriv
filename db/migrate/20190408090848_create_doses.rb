class CreateDoses < ActiveRecord::Migration[5.2]
  def change
    create_table :doses do |t|
      t.references :dish, foreign_key: true
      t.references :nutrition, foreign_key: true
      t.integer :amount
      t.string :unit

      t.timestamps
    end
  end
end
