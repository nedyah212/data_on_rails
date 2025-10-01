class Manufacturer < ApplicationRecord
  has_many :cars
  has_many :features

  validates :name, presence: true, uniqueness: true
end
