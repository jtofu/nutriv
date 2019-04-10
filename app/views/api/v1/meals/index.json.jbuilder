json.meals @meals do |meal|
  json.extract! meal, :id, :name
end
