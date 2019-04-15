json.extract! @dish, :id, :name, :image
json.nutrients @dish.doses do |dose|
  json.name dose.nutrient.name
  json.unit dose.nutrient.unit
  json.extract! dose, :amount
end
