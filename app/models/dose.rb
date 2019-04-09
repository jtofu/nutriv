class Dose < ApplicationRecord
  belongs_to :dish
  belongs_to :nutrient
end
