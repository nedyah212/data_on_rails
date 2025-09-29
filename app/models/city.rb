class City < ApplicationRecord
  has_many :people
  has_many :dealerships

  validates :name, presence: true, uniqueness: { scope: :province }
  validates :province, presence: true
  validates :country, presence: true
  validates :population, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }, allow_nil: true
end
