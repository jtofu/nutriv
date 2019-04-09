class Order < ApplicationRecord
  has_many :order_items
  has_many :dishes, through: :order_items
end
