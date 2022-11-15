require 'rails_helper'

RSpec.describe 'Flights index page', type: :feature do
  before(:each) do
    @passenger_1 = Passenger.create!(name: 'Arnold', age: 50)
    @passenger_2 = Passenger.create!(name: 'Debbie', age: 52)
    @passenger_3 = Passenger.create!(name: 'Rex', age: 25)
    @passenger_4 = Passenger.create!(name: 'Will', age: 50)
    @passenger_5 = Passenger.create!(name: 'Tom', age: 17)
    @passenger_6 = Passenger.create!(name: 'Maverick', age: 13)

    @airline_1 = Airline.create!(name: 'American')
    @airline_2 = Airline.create!(name: 'Delta')
    @airline_3 = Airline.create!(name: 'Frugal')
    @airline_4 = Airline.create!(name: 'Jetblue')

    @flight_1 = @airline_1.flights.create!(number: 'AA_1', date: '04/18/19', departure_city: 'Seattle',
                                           arrival_city: 'Portland')
    @flight_2 = @airline_2.flights.create!(number: 'DA_2', date: '04/19/19', departure_city: 'L.A.',
                                           arrival_city: 'Sacramento')
    @flight_3 = @airline_3.flights.create!(number: 'FA_3', date: '04/20/19', departure_city: 'L.A.',
                                           arrival_city: 'Sacramento')
    @flight_4 = @airline_4.flights.create!(number: 'JB_4', date: '05/28/19', departure_city: 'Cleveland',
                                           arrival_city: 'Dallas')
    @flight_5 = @airline_1.flights.create!(number: 'AA_5', date: '08/29/19', departure_city: 'New Orleans',
                                           arrival_city: 'New York')
    @flight_2 = @airline_3.flights.create!(number: 'DA_2', date: '08/29/19', departure_city: 'L.A.',
                                           arrival_city: 'Sacramento')

    FlightPassenger.create(flight_id: @flight_1.id, passenger_id: @passenger_1.id)
    FlightPassenger.create(flight_id: @flight_1.id, passenger_id: @passenger_2.id)
    FlightPassenger.create(flight_id: @flight_1.id, passenger_id: @passenger_4.id)
    FlightPassenger.create(flight_id: @flight_2.id, passenger_id: @passenger_1.id)
    FlightPassenger.create(flight_id: @flight_2.id, passenger_id: @passenger_5.id)
    FlightPassenger.create(flight_id: @flight_3.id, passenger_id: @passenger_2.id)
    FlightPassenger.create(flight_id: @flight_4.id, passenger_id: @passenger_3.id)
    FlightPassenger.create(flight_id: @flight_5.id, passenger_id: @passenger_4.id)
    FlightPassenger.create(flight_id: @flight_2.id, passenger_id: @passenger_2.id)
  end
  describe 'When I visit the flights index page i see a lot of information' do
    it 'I see a list of all the flight numbers' do
      visit flights_path
      expect(page).to have_content(@flight_1.number)
      expect(page).to have_content(@flight_1.airline.name)
      expect(page).to have_content(@flight_2.number)
      expect(page).to have_content(@flight_2.airline.name)
      expect(page).to have_content(@flight_3.number)
      expect(page).to have_content(@flight_3.airline.name)
      expect(page).to have_content(@flight_4.number)
      expect(page).to have_content(@flight_4.airline.name)
      expect(page).to have_content(@flight_5.number)
      expect(page).to have_content(@flight_5.airline.name)
      save_and_open_page
    end
  end
    it "under each flight, it displays the names of all that flight's passengers" do
      visit flights_path
      within("#flight-#{@flight_1.id}") do
      expect(page).to have_content(@passenger_1.name)
      expect(page).to have_content(@passenger_2.name)
      expect(page).to have_content(@passenger_4.name)
   

      expect(page).to_not have_content(@passenger_6.name)
      end
   end

  # User Story 2, Remove a Passenger from a Flight
  # When I visit the flights index page
  # Next to each passengers name
  # I see a link or button to remove that passenger from that flight
  # When I click on that link/button
  # I'm returned to the flights index page
  # And I no longer see that passenger listed under that flight,
  # And I still see the passenger listed under the other flights they were assigned to
  describe 'Removing a passenger from a flight' do
    it 'Removes a passanger from flight with a button next to the name' do
      visit flights_path
       within("#passenger-#{@passenger_3.id}") do
       expect(page).to have_content(@passenger_3.name)
       click_button('Remove Passenger')
       end
       expect(current_path).to eq(flights_path)
       expect(page).to_not have_content(@passenger_3.name)
       
      end
      
  end
end