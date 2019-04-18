class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :fake_name
      t.string :address_en
      t.string :address_cn
      t.float :long
      t.float :lat
      t.string :url

      t.timestamps
    end
  end
end
