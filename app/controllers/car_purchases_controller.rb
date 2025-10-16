class CarPurchasesController < ApplicationController
  def index
    @car_purchases = CarPurchase.includes(:car, :person, :dealership, :salesperson).all
      .joins(:dealership)
      .order('dealerships.name ASC')
      .page params[:page]
  end
end