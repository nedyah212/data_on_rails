class PeopleController < ApplicationController
  def index
    #Lets not display people who are salespeople,
    #Only displays carless people who are not salespeople
    @people = Person.left_joins(:salesperson, :car_purchases)
      .where(salespeople: { id: nil })
      .where(car_purchases: { id: nil })
  end

  def show
    @person = Person.find(params[:id])
  end
end
