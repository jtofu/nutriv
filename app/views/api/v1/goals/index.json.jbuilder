json.extract! @user, :id, :wechat_id, :username
json.goals @user.goals do |goal|
  json.name goal.nutrient.name
  json.unit goal.nutrient.unit
  json.extract! goal, :amount, :id
end
