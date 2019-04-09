class AddColumnsToNutrients < ActiveRecord::Migration[5.2]
  def change
    add_column :nutrients, :unit, :string
    add_column :nutrients, :api_code, :string
  end
end
