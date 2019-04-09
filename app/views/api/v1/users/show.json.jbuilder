json.extract! @user, :id, :wechat_id, :username, :profile_image, :first_name, :last_name
json.goals @user.goals do |goal|
  json.extract! goal, :id, :title,:amount, :unit
end
