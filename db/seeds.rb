
# puts "Destroying Doses..."
# Dose.destroy_all if Rails.env.development?
# puts "Destroyed Doses."


# # SEEDING NUTRIENT
# puts "Destroying Nutrients...."
# Nutrient.destroy_all if Rails.env.development?
# puts "Destroyed Nutrients."

# nutrients = [{ name: 'Carbohydrate', unit: 'g', api_code: 'nf_total_carbohydrate' },
# { name: 'Cholesterol', unit: 'mg', api_code: 'nf_cholesterol' },
# { name: 'Calories', unit: 'kcal', api_code: 'nf_calories' },
# { name: 'Saturated Fat', unit: 'g', api_code: 'nf_saturated_fat' },
# { name: 'Total Fat', unit: 'g', api_code: 'nf_total_fat' },
# { name: 'Trans Fatty Acid', unit: 'g', api_code: 'nf_trans_fatty_acid' },
# { name: 'Dietary Fiber', unit: 'g', api_code: 'nf_dietary_fiber' },
# { name: 'Sodium', unit: 'mg', api_code: 'nf_sodium' },
# { name: 'Protein', unit: 'g', api_code: 'nf_protein' },
# { name: 'Sugars', unit: 'g', api_code: 'nf_sugars' }]

# puts "Seeding nutrients.."

# nutrients.each do |n|
#   Nutrient.create!(name: n[:name], unit: n[:unit], api_code: n[:api_code])
#   # p n[:name]
# end

# puts "Created #{Nutrient.count} nutrients."


app_id = ENV["X_APP_ID"]
app_key = ENV["X_APP_KEY"]

puts "Destroying meal, dish & dose"

Meal.destroy_all if Rails.env.development?
Dose.destroy_all if Rails.env.development?
Dish.destroy_all if Rails.env.development?

puts "Seeding dish & dose.."


queries = %w(pancake sandwich salad poke granola)
# query = "salad"
url = "https://trackapi.nutritionix.com/v2/search/"

queries.each do |query|

  dish_data = RestClient.get("#{url}instant?query=#{query}", headers={"x-app-id": app_id, "x-app-key": app_key})
  dish_parsed = JSON.parse(dish_data)

  dish_parsed["branded"].each do |item|
    unless item["nix_item_id"].nil?
      nix_item_id = item["nix_item_id"]
      dish = Dish.create!(name: "#{item["food_name"]} #{query}")

      dose_data = RestClient.get("https://trackapi.nutritionix.com/v2/search/item?nix_item_id=#{nix_item_id}", headers={"x-app-id": app_id, "x-app-key": app_key})

      dose_parsed = JSON.parse(dose_data)

      Dose.create!(dish: dish, amount: dose_parsed["foods"].first[ "nf_total_carbohydrate"].to_i, nutrient: Nutrient.find_by(api_code: "nf_total_carbohydrate")) unless Nutrient.find_by(api_code: "nf_total_carbohydrate").nil?

      Dose.create!(dish: dish, amount: dose_parsed["foods"].first[ "nf_calories"].to_i, nutrient: Nutrient.find_by(api_code: "nf_calories")) unless Nutrient.find_by(api_code: "nf_calories").nil?

      Dose.create!(dish: dish, amount: dose_parsed["foods"].first[ "nf_total_fat"].to_i, nutrient: Nutrient.find_by(api_code: "nf_total_fat")) unless Nutrient.find_by(api_code: "nf_total_fat").nil?

      Dose.create!(dish: dish, amount: dose_parsed["foods"].first[ "nf_saturated_fat"].to_i, nutrient: Nutrient.find_by(api_code: "nf_saturated_fat")) unless Nutrient.find_by(api_code: "nf_saturated_fat").nil?

      Dose.create!(dish: dish, amount: dose_parsed["foods"].first[ "nf_cholesterol"].to_i, nutrient: Nutrient.find_by(api_code: "nf_cholesterol")) unless Nutrient.find_by(api_code: "nf_cholesterol").nil?

      Dose.create!(dish: dish, amount: dose_parsed["foods"].first[ "nf_sodium"].to_i, nutrient: Nutrient.find_by(api_code: "nf_sodium")) unless Nutrient.find_by(api_code: "nf_sodium").nil?

      Dose.create!(dish: dish, amount: dose_parsed["foods"].first[ "nf_dietary_fiber"].to_i, nutrient: Nutrient.find_by(api_code: "nf_dietary_fiber")) unless Nutrient.find_by(api_code: "nf_dietary_fiber").nil?

      Dose.create!(dish: dish, amount: dose_parsed["foods"].first[ "nf_sugars"].to_i, nutrient: Nutrient.find_by(api_code: "nf_sugars")) unless Nutrient.find_by(api_code: "nf_sugars").nil?

      Dose.create!(dish: dish, amount: dose_parsed["foods"].first[ "nf_protein"].to_i, nutrient: Nutrient.find_by(api_code: "nf_protein")) unless Nutrient.find_by(api_code: "nf_protein").nil?

      Dose.create!(dish: dish, amount: dose_parsed["foods"].first[ "nf_potassium"].to_i, nutrient: Nutrient.find_by(api_code: "nf_potassium")) unless Nutrient.find_by(api_code: "nf_potassium").nil?

      puts "Created #{dish}."
    end
  end

end



puts "Created #{Dish.count} dishes."
puts "Created #{Dose.count} doses."

# dose_data = RestClient.get("https://trackapi.nutritionix.com/v2/search/item?nix_item_id=5b98bc815934e8a54010573f", headers={"x-app-id": app_id, "x-app-key": app_key})

# dose_parsed = JSON.parse(dose_data)

# p dose_parsed["foods"].first[ "nf_total_fat"]


# nix_item_id =



# https://trackapi.nutritionix.com/v2/search/item?nix_item_id=5b98bc815934e8a54010573f

# p filtered
# p nixes


