json.meals @meals do |meal|
  json.extract! meal, :id, :quantity
  json.date meal.created_at.in_time_zone("Beijing").strftime('%Y-%m-%e')
  json.time meal.created_at.in_time_zone("Beijing").strftime('%l:%M %p')
  json.dish meal.dish.name
  json.dish_short meal.dish.name[0..20] + ".."
    json.nutrients meal.dish.doses do |dose|
      json.name dose.nutrient.name
      json.unit dose.nutrient.unit
      json.extract! dose, :amount
    end
end
