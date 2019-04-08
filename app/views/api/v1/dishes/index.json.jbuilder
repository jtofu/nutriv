json.dishes @dishes do |dish|
  json.extract! dish, :id, :name
  json.nutritions dish.doses do |dose|
    json.name dose.nutrition.name
    json.extract! dose, :amount, :unit
  end
end
