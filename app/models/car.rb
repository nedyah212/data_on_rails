class Car < ApplicationRecord
  belongs_to :manufacturer
  has_many :car_purchases
  has_many :people, through: :car_purchases
  has_many :car_features
  has_many :features, through: :car_features
end
