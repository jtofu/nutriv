class User < ApplicationRecord
  has_many :goals
  has_many :meals
  validates :wechat_id, presence: true, uniqueness: true
end
