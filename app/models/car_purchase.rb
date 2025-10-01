class CarPurchase < ApplicationRecord
  belongs_to :car
  belongs_to :person
  belongs_to :dealership

  validates :purchase_date, presence: true
  validates :price_paid, numericality: {
    greater_than: 0
}
  validates :financing_type, inclusion: {
    in: ['cash', 'loan', 'lease'],
    message: "%{value} is not a valid financing type"
  }, allow_nil: false
  validates :kilometers_at_purchase, numericality: {
    only_integer: true, greater_than_or_equal_to: 0
  }, allow_nil: false
  validates :condition, inclusion: {
    in: ['new', 'used', 'certified pre-owned'],
    message: "%{value} is not a valid condition"
  }, allow_nil: false
end
