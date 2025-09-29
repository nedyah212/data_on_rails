class CarFeature < ApplicationRecord
  belongs_to :car
  belongs_to :feature

  validates :car_id, uniqueness: {
    scope: :feature_id,
    message: "This feature allready exists for this car"
  }
  validates :cost, numericality: {
    greater_than_or_equal_to: 0
  }, allow_nil: false
  validates :is_standard, includion: {
    in: [true, false],
    message: "must be true or false"
  }, allow_nil: false
end
