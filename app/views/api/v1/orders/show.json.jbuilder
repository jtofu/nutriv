json.extract! @order, :id
json.dishes @order.order_items do |oi|
  json.extract! oi.dish, :id, :name, :image
  json.extract! oi, :quantity
  json.nutrients oi.dish.doses do |dose|
    json.name dose.nutrient.name
    json.unit dose.nutrient.unit
    json.extract! dose, :amount
  end
end
# json.extract! @schedule, :id, :start_time, :end_time
