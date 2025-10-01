class CarPurchasesController < ApplicationController
  def index
    @car_purchases = CarPurchase.includes(:car, :person, :dealership, :salesperson).all
  end

  def show
    @car_purchase = CarPurchase.find(params[:id])
  end
end
