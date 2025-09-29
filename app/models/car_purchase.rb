class CarPurchase < ApplicationRecord
  belongs_to :car
  belongs_to :person
  belongs_to :dealership
end
