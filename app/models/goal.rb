class Goal < ApplicationRecord
  belongs_to :user
  belongs_to :nutrient

  validates :amount, numericality: true
  validates :user, uniqueness: { scope: :nutrient,
    message: "Each nutrient is unique to each user" }
end
