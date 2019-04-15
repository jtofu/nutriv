require 'open-uri'

puts "Destroying children first... goals, order items, doses and meals..."
Dose.destroy_all if Rails.env.development?
Meal.destroy_all if Rails.env.development?
Goal.destroy_all if Rails.env.development?
OrderItem.destroy_all if Rails.env.development?

puts "Children destroyed!"

puts "Destroying orders, dishes & nutrients.."
Order.destroy_all if Rails.env.development?
Dish.destroy_all if Rails.env.development?
Nutrient.destroy_all if Rails.env.development?

puts "Orders, Dishes and Nutrients destroyed!"

puts "Seeding nutrients.."

nutrients = [{ name: 'Carbohydrate', unit: 'g', api_code: 'nf_total_carbohydrate' },
{ name: 'Cholesterol', unit: 'mg', api_code: 'nf_cholesterol' },
{ name: 'Calories', unit: 'kcal', api_code: 'nf_calories' },
{ name: 'Saturated Fat', unit: 'g', api_code: 'nf_saturated_fat' },
{ name: 'Total Fat', unit: 'g', api_code: 'nf_total_fat' },
{ name: 'Trans Fatty Acid', unit: 'g', api_code: 'nf_trans_fatty_acid' },
{ name: 'Dietary Fiber', unit: 'g', api_code: 'nf_dietary_fiber' },
{ name: 'Sodium', unit: 'mg', api_code: 'nf_sodium' },
{ name: 'Protein', unit: 'g', api_code: 'nf_protein' },
{ name: 'Sugars', unit: 'g', api_code: 'nf_sugars' }]

nutrients.each do |n|
  Nutrient.create!(name: n[:name], unit: n[:unit], api_code: n[:api_code])
end

puts "Created #{Nutrient.count} nutrients."

puts "Seeding dishes & doses..."
base_url = "https://www.foodnetwork.com/healthy/packages/healthy-every-week/healthy-mains/foodnetwork-most-saved-healthy-recipes#item-"

file_one = Nokogiri::HTML(File.open("db/foodnetwork1.html"), nil, 'utf-8')

dishes = []

file_one.search('.o-PhotoGalleryPromo__a-Cta a').first(40).each do |res|
  url = res["href"].gsub("//","https://")
  item = Nokogiri::HTML(open(url).read)

  image = item.at_css('img.m-MediaBlock__a-Image')["src"].gsub("//","https://")
  name = res.text.strip.gsub("Get the Recipe:\n      \n        ","")

  unless item.at_css('#nutrition-content').nil?
    count_nutrient = item.at_css('#nutrition-content').css('dt').count

    nutrients = []

    item.search('.m-NutritionTable__a-Headline').each do |nutrient|
      if nutrient.text == "Carbohydrates"
        n_name = "Carbohydrate"
      elsif nutrient.text == "Sugar"
        n_name = "Sugars"
      else
        n_name = nutrient.text
      end

      nutrients << { name: n_name }
    end

    i = 0
    until i == (count_nutrient - 1) do
      nutrients[i][:amount] = item.search('.m-NutritionTable__a-Description')[i].text.split(" ").first.to_i
      i += 1
    end

    nutrients = nutrients.uniq

    dish = Dish.create!(name: name, image: image)

    nutrients.each do |n|
      dose = Dose.new(nutrient: Nutrient.find_by(name: n[:name]))
      dose.dish = dish
      dose.amount = n[:amount]
      dose.save
    end

    puts "Created #{dish.name}."
  end
end

puts "Created #{Dish.count} dishes."
puts "Created #{Dose.count} doses."
