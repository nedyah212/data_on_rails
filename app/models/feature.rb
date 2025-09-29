class Feature < ApplicationRecord
  has_many :car_features
  has_many :cars, through: :car_features
end
