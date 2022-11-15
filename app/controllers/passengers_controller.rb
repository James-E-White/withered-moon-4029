class PassengersController < ApplicationController
  def index
    @passenger = Passenger.all
  end
end