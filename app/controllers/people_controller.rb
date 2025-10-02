class PeopleController < ApplicationController
  def index
    #Lets not display people who are salespeople,
    #this page could be used to retarget customers
    @people = Person.left_joins(:salesperson).where(salespeople: { id: nil })
  end

  def show
    @person = Person.find(params[:id])
  end
end
