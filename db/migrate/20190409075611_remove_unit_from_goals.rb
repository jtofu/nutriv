class RemoveUnitFromGoals < ActiveRecord::Migration[5.2]
  def change
    remove_column :goals, :unit, :string
  end
end
