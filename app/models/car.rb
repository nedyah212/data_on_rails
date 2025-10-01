class Car < ApplicationRecord
  belongs_to :manufacturer
  has_many :car_purchases
  has_many :people, through: :car_purchases
  has_many :car_features
  has_many :features, through: :car_features

  validates :manufacturer_id, presence: true
  validates :model, presence: true
  validates :color, presence: true
  validates :trim, presence: true
  validates :year, numericality: {
    only_integer: true, greater_than: 1950,
    less_than_or_equal_to: Date.current.year + 1
  }
end
