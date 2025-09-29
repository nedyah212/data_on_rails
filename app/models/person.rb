class Person < ApplicationRecord
  belongs_to :city
  has_many :car_purchases
  has_many :cars, through: :car_purchases
end
