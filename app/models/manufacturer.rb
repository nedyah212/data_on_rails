class Manufacturer < ApplicationRecord
  has_many :cars

  validates :name, presence: true, uniqueness: true
  validates :country, presence: true
  validates :founded, numericality: {
    only_integer: true, greater_than: 1880,
    less_than_or_equal_to: Date.current.year
  }
end
