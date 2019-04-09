class RemoveUnitFromDoses < ActiveRecord::Migration[5.2]
  def change
    remove_column :doses, :unit, :string
  end
end
