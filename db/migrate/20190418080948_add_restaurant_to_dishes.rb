class AddRestaurantToDishes < ActiveRecord::Migration[5.2]
  def change
    add_reference :dishes, :restaurant, foreign_key: true
  end
end
