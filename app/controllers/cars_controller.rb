class CarsController < ApplicationController
  def index
    # Cars that have not been purchased yet (i.e. not in CarPurchase)
    purchased_car_ids = CarPurchase.pluck(:car_id)
    @cars = Car.where.not(id: purchased_car_ids)
      .order(:id)
      .page params[:page]
  end

  def show
    @car = Car.find(params[:id])
    @car_purchases = CarPurchase.includes(:person, :dealership, :salesperson).where(car_id: @car.id)
  end
end
