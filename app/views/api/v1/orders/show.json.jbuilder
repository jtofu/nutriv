json.extract! @order, :id
json.dishes @order.order_items do |oi|
  json.extract! oi.dish, :id, :name
end
# json.extract! @schedule, :id, :start_time, :end_time
