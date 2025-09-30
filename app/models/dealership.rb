class Dealership < ApplicationRecord
  belongs_to :city
  has_many :car_purchases

  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :phone, format: {
    with: /\A\+?[0-9\s\-\(\)]+\z/,
    message: "must be a valid phone number"
}
end
