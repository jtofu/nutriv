json.extract! @user, :id, :wechat_id, :username, :profile_image, :first_name, :last_name
json.last7d @last7d_cal
json.todayCal @last7d_cal[-1]
json.todayProtein @sum_protein
json.todayFat @sum_fat

json.goalCal @goalCal
json.goalProtein @goalProtein
json.goalFat @goalFat

json.goals @user.goals do |goal|
  json.extract! goal, :id, :amount
  json.unit goal.nutrient.unit
  json.name goal.nutrient.name
end

json.meals @user.meals do |meal|
  json.extract! meal, :id, :quantity
  json.date meal.created_at.in_time_zone("Beijing").strftime('%Y-%m-%e')
  json.time meal.created_at.in_time_zone("Beijing").strftime('%l:%M %p')
  json.dish meal.dish.name
  json.dish_short meal.dish.name[0..20] + ".."
  json.image meal.dish.image
    json.nutrients meal.dish.doses do |dose|
      json.name dose.nutrient.name
      json.unit dose.nutrient.unit
      json.extract! dose, :amount
    end
end
