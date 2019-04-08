class Dose < ApplicationRecord
  belongs_to :dish
  belongs_to :nutrition
end
