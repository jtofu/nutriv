class Nutrition < ApplicationRecord
  has_many :doses
  has_many :dishes, through: :doses
  has_many :goals
end
