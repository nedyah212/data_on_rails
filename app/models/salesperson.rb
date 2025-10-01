class Salesperson < ApplicationRecord
  belongs_to :person
  belongs_to :dealership
end
