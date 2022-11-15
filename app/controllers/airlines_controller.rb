class AirlinesController < ApplicationController
  def show
    @airlines = Airline.find(params:id)
  end
end