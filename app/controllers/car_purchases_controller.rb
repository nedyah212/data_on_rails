class CarPurchasesController < ApplicationController
  def index
    @car_purchases = CarPurchase.includes(:car, :person, :dealership, :salesperson).all
  end
end
