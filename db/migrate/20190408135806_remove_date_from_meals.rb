class RemoveDateFromMeals < ActiveRecord::Migration[5.2]
  def change
    remove_column :meals, :date, :datetime
  end
end
