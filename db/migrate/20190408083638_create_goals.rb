class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.references :user, foreign_key: true
      t.references :nutrition, foreign_key: true
      t.integer :amount
      t.string :unit

      t.timestamps
    end
  end
end
