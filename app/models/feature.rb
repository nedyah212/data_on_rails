class Feature < ApplicationRecord
  has_many :car_features
  has_many :cars, through: :car_features

  validates :name, presence: true, uniqueness: true
  validates :category, presence: true
  validates :base_cost, numericality: {
    greater_than_or_equal_to: 0
}, allow_nil: true
end
