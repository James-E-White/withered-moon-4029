require 'rails_helper'

RSpec.describe "Airlines show page", type: :feature do
  
# User Story 3, Airline's Passengers
# # As a visitor
# # When I visit an airline's show page
# # Then I see a list of passengers that have flights on that airline
# # And I see that this list is unique (no duplicate passengers)
# # And I see that this list only includes adult passengers
# # (Note: an adult is anyone with age greater than or equal to 18)
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

   describe 'When I visit the airlines show page i see a lot of passengers information' do 
     it 'I see a list of all the passengers that have flights' do 
      visit airlines_path
      expect(page).to have_content(@passenger_1.name)
      expect(page).to have_content(@passenger_2.name)
      expect(page).to have_content(@passenger_3.name)
      expect(page).to have_content(@passenger_4.name)
      expect(page).to have_content(@passenger_5.name)
      save_and_open_page
     end
    end

      it 'shows no duplicate passengers' do 
        expect(page).to have_content(@passenger_1.name)
        expect(page).to have_content(@passenger_2.name)
        expect(page).to have_content(@passenger_3.name)
        expect(page).to have_content(@passenger_4.name)
        expect(page).to have_content(@passenger_5.name)
      end

      it 'shows only passengers that are 18+ adults' do 
        
        expect(page).to have_content(@passenger_1.name)
        expect(page).to have_content(@passenger_2.name)
        expect(page).to have_content(@passenger_3.name)
        expect(page).to have_content(@passenger_4.name)

        expect(page).to_not have_content(@passenger_5.name)
        expect(page).to_not have_content(@passenger_6.name)
        
      end
end