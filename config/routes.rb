Rails.application.routes.draw do
  resources :flights, only: :index
  resources :flight_passengers, only: [:destroy]
  resources :airlines, only: [:show]
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
