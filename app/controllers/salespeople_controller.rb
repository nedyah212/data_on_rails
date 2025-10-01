class SalespeopleController < ApplicationController
  before_action :set_salesperson, only: %i[ show edit update destroy ]

  # GET /salespeople or /salespeople.json
  def index
    @salespeople = Salesperson.all
  end

  # GET /salespeople/1 or /salespeople/1.json
  def show
  end
end
