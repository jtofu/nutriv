json.extract! @user, :id, :goals, :wechat_id, :username
json.goals @user.goals do
  json.array! do |goal|
     json.extract! goal, :id, :user_id, :nutrient_id, :amount, :unit
  end
end
