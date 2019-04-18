json.extract! @user, :id, :wechat_id, :username, :profile_image, :first_name, :last_name
json.last7dCal @last7d_cal
json.last7dProtein @last7d_protein
json.last7dFat @last7d_fat

json.todayCal @last7d_cal[-1]
json.todayProtein @sum_protein
json.todayFat @sum_fat
json.todayCarb @sum_carb
json.todayCholestrol @sum_cholestrol
json.todaySatFat @sum_sat_fat
json.todayTransFat @sum_trans_fat
json.todayFiber @sum_fiber
json.todaySodium @sum_sodium
json.todaySugar @sum_sugar

json.goalCal @goal_cal
json.goalProtein @goal_protein
json.goalFat @goal_fat
json.goalCarb @goal_carb
json.goalCholestrol @goal_cholestrol
json.goalSatFat @goal_sat_fat
json.goalTransFattyAcid @goal_trans_fat
json.goalFiber @goal_fiber
json.goalSodium @goal_sodium
json.goalSugar @goal_sugar

json.goals @user.goals do |goal|
  json.extract! goal, :id, :amount
  json.unit goal.nutrient.unit
  json.name goal.nutrient.name
end

json.meals @meals do |meal|
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
