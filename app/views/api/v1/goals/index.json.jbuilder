json.extract! @user, :id, :goals, :wechat_id, :username
json.goals @user.goals do
  json.array! do |goal|
     json.extract! goal, :id, :user_id, :nutrient_id, :amount, :unit
    json.date review.created_at.strftime("%m/%d/%y")
  end
end
