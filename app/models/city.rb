class City < ApplicationRecord
  has_many :people
  has_many :dealerships
end
