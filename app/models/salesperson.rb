class Salesperson < ApplicationRecord
  belongs_to :person
  belongs_to :dealership
  has_many :car_purchases
end
