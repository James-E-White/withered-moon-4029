class FlightPassengersController < ApplicationController

  def destroy
    flight = Flight.find(params[:id])
    passenger = Passenger.find(params[:passenger_id])
    flight.passengers.delete(passenger)
    redirect_to flights_path
  end
end