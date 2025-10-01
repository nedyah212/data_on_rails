class Person < ApplicationRecord
  belongs_to :city
  has_many :car_purchases
  has_many :cars, through: :car_purchases

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: {
    with: URI::MailTo::EMAIL_REGEXP,
    message: "must be a valid email address"
  }
  validates :age, numericality: {
    only_integer: true, greater_than_or_equal_to: 18
  }, allow_nil: true
  validates :phone, format: {
    with: /\A\+?[0-9\s\-\(\)]+\z/,
    message: "must be a valid phone number"
  }, allow_nil: true
end
