json.orders do
  json.array! @orders do |order|
    json.extract! order, :id, :order_time
  end
end
