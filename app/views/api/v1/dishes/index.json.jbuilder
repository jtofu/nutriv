json.dishes do
  json.array! @dishes do |dish|
    json.extract! dish, :id, :name
  end
end
