class Car < ApplicationRecord
  belongs_to :manufacturer
  has_many :car_purchases
  has_many :people, through: :car_purchases
  has_many :car_features
  has_many :features, through: :car_features

  validates :make, presence: true
  validates :model, presence: true
  validates :color, presence: true
  validates :engine_size, presence: true
  validates :year, numericality: {
    only_integer: true, greater_than: 1885,
    less_than_or_equal_to: Date.current.year + 1
  }
  validates :base_price, numericality: {
    greater_than_or_equal_to: 0
  } allow_nil: true
  validates :kilometers, numericality: {
    only_integer: true, greater_than_or_equal_to: 0
  } allow_nil: true
  validates :transmission, inclusion: {
    in: ['automatic', 'manual', 'cvt', 'semi-automatic'],
      message: "%{value} is not a valid transmission"
    }, allow_nil: true
    end
