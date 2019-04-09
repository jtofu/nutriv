json.extract! @goal, :id, :user_id, :nutrient_id, :amount, :unit
json.nutrient @goal.nutrient.name


