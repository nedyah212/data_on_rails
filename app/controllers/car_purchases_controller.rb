class CarPurchasesController < ApplicationController
  def index
    @car_purchases = CarPurchase.includes(:car, :person, :dealership, :salesperson).all
      .joins(:dealership)
      .order('dealerships.name ASC')
      .page params[:page]
  end

  def search
    @query = params[:query]

    if @query.present?
      @results = CarPurchase.where("cars.name LIKE ?", "%#{@query}%")
        .includes(:car, :person, :dealership, :salesperson)
        .joins(:car)
    else
      @results = []
    end
  end
end