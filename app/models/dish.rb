class Dish < ApplicationRecord
  has_many :doses
  has_many :nutrients, through: :doses
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :meals
  has_many :users, through: :meals
end
