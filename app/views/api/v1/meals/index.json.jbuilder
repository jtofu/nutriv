json.meals @meals do |meal|
  json.extract! meal, :id
  json.date meal.created_at.strftime('%Y-%m-%e')
  json.time meal.created_at.strftime('%l:%M %p')
  json.dish meal.dish.name
    json.nutrients meal.dish.doses do |dose|
      json.name dose.nutrient.name
      json.unit dose.nutrient.unit
      json.extract! dose, :amount
    end
end
