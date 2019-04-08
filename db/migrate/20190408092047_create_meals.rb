class CreateMeals < ActiveRecord::Migration[5.2]
  def change
    create_table :meals do |t|
      t.datetime :date
      t.references :user, foreign_key: true
      t.references :order_item, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
