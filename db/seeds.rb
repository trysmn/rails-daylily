# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'json'

url = "https://raw.githubusercontent.com/ram-nadella/airport-codes/master/airports.json"

puts "Reading the json file..."
airports_file = open(url).read
puts "Done!"

puts "Storing the content of the json file in a hash..."
airports_hash = JSON.parse(airports_file)
puts "Done!"


puts "Deleting all current event_categories..."
EventCategory.destroy_all
puts "Done!"

puts "Deleting all current event_terrains..."
EventTerrain.destroy_all
puts "Done!"

puts "Deleting all current events..."
Event.destroy_all
puts "Done!"

puts "Deleting all current airport cities..."
CityAirport.destroy_all
puts "Done!"

puts "Deleting all current categories..."
Category.destroy_all
puts "Done!"

puts "Deleting all current terrains..."
Terrain.destroy_all
puts "Done!"

puts "Creating all necessary airport cities..."
iata_codes_array = ["LON","PAR","MIL","BCN","BER","MAD","VIE","DUB","AMS","BRU","BSL"]
iata_codes_array.each do |iata,index|
  CityAirport.create!(city_name: airports_hash[iata]["city"], iata_code: airports_hash[iata]["iata"])
end
puts "Done!"

puts "Seeding categories..."
categories_array = ["Food","Music","Beer","Cocktail","Sport","Book","Art/Design","Film","Wine"]
categories_array.each do |category|
  Category.create!(name: category)
end
puts "Done!"

puts "Seeding terrains..."
terrains_array = ["Desert","Forest","Grassland","Hills","Jungle","Mountain","Plain","River","Tundra","Urban","Rural","Beach","Park"]
terrains_array.each do |terrain|
  Terrain.create!(name: terrain)
end
puts "Done!"

puts "Seeding events..."
events_array = [ { title: "London Cocktail Week",
  description: "Join a seven-day cocktail party celebrating the capital's top bars, mixologists and cocktail scene during London Cocktail Week (LCW). Hosted by DrinkUp.London, the same team behind London Beer Week and Wine Week, the annual festival features a vibrant cocktail village as well as special offers at more than 250 bars, restaurants and pop-ups all…",
  start_date: Date.parse('2nd Oct 2017'),
  end_date: Date.parse('8th Oct 2017'),
  average_temp: 12,
  entrance_fee: 0,
  website: "https://drinkup.london/cocktailweek/",
  user_id: 1,
  status: "approved",
  address: "16 Horner Square, London E1 6EW, UK",
  city_airport_id: CityAirport.first.id },

  { title: "Frieze Sculpture park",
    description: "Wander through a stunning outdoor exhibition featuring works by some of the world’s most famous sculptors with Frieze Sculpture 2017 in Regent’s Park's English Gardens. Bringing together 25 sculptures by acclaimed 20th-century and contemporary artists, Frieze Sculpture is a great way to get a taste of Frieze Masters and Frieze London, before…",
    start_date: Date.parse('2th Oct 2017'),
    end_date: Date.parse('8th Oct 2017'),
    average_temp: 12,
    entrance_fee: 0,
    website: "https://frieze.com/article/frieze-sculpture-2017-0",
    user_id: 1,
    status: "approved",
    address: "Chester Rd, London NW1 4NR, UK",
    city_airport_id: CityAirport.first.id },

  { title: "Cinekid Festival",
    description: "The Cinekid Festival is an annual film, television and new-media festival for children across the Netherlands, attended by more than 50,000 children and (international) guests every year. The festival traditionally takes place at Amsterdam’s Westergasfabriek in September or October, around the autumn school holidays.",
    start_date: Date.parse('21st Oct 2017'),
    end_date: Date.parse('23rd Oct 2017'),
    average_temp: 13,
    entrance_fee: 0,
    website: "https://www.cinekid.nl/english/festival",
    user_id: 1,
    status: "approved",
    address: "Kattenburgerstraat 5, 1018 JA Amsterdam, Netherlands",
    city_airport_id: CityAirport.all[8].id },

  { title: "Read My World",
    description: "Read My World is the international literature festival of Amsterdam. Going beyond the commonplace, it explores the boundaries of literature and journalism and draws attention to everything in between. It traditionally takes place in October at the Tolhuistuin.",
    start_date: Date.parse('12th Oct 2017'),
    end_date: Date.parse('14th Oct 2017'),
    average_temp: 13,
    entrance_fee: 15,
    website: "http://www.readmyworld.nl/tickets/",
    user_id: 1,
    status: "approved",
    address: "Amsterdam, Netherlands",
    city_airport_id: CityAirport.all[8].id },

  { title: "Barcelona Wine and Cava Festival",
    description: "The Mostra de Vins i Caves de Catalunya is once again at the Arc de Triomf monument on Passeig de Lluis Company.  Taking part are over 70 top wineries present wines from 12 Catalan denominations of origin including DO Alella, Catalonia, Cava, Conca de Barbera, Costers del Segre, Empordà Montsant Penedès Pla de Bages, Priorat, Tarragona and Terra…",
    start_date: Date.parse('27th Oct 2017'),
    end_date: Date.parse('29th Oct 2017'),
    average_temp: 21,
    entrance_fee: 0,
    website: "http://www.barcelonayellow.com/bcn-events-calendar/details/761-merce-wine-and-cava-festival",
    user_id: 1,
    status: "approved",
    address: "Passeig de Lluís Companys, 08003, Barcelona, Spain",
    city_airport_id: CityAirport.all[3].id },

  { title: "Barcelona Boat Show",
    description: "The 2017 Barcelona Boat Show welcomes you to the 55th edition. Barcelona boat show is a 5 day boat show with over 300 Spanish and foreign exhibitors, around 700 boats and more than 1,300 sailors taking part in the annual Catalan Sailing Week. The Barcelona boat show is a floating boat show in Barcelona's marina the Port Vell marina with more than…",
    start_date: Date.parse('11th Oct 2017'),
    end_date: Date.parse('15th Oct 2017'),
    average_temp: 21,
    entrance_fee: 0,
    website: "http://www.barcelonayellow.com/bcn-events-calendar/details/89-barcelona-boat-show-salon-nautico",
    user_id: 1,
    status: "approved",
    address: "Carrer de l'Escar, 26, 08039 Barcelona",
    city_airport_id: CityAirport.all[3].id } ]

events_array.each do |event|
  Event.create!(event)
end
puts "Done!"

puts "Adding a category to each event:"
EventCategory.create!(event_id: Event.first.id, category_id: Category.all[3].id)
EventCategory.create!(event_id: Event.all[1].id, category_id: Category.all[6].id)
EventCategory.create!(event_id: Event.all[2].id, category_id: Category.all[7].id)
EventCategory.create!(event_id: Event.all[3].id, category_id: Category.all[5].id)
EventCategory.create!(event_id: Event.all[4].id, category_id: Category.all[8].id)
EventCategory.create!(event_id: Event.all[5].id, category_id: Category.all[4].id)
puts "Done!"

puts "Adding terrains to each event"
EventTerrain.create!(event_id: Event.first.id, terrain_id: Terrain.all[9].id)
EventTerrain.create!(event_id: Event.all[1].id, terrain_id: Terrain.all[12].id)
EventTerrain.create!(event_id: Event.all[2].id, terrain_id: Terrain.all[9].id)
EventTerrain.create!(event_id: Event.all[3].id, terrain_id: Terrain.all[9].id)
EventTerrain.create!(event_id: Event.all[4].id, terrain_id: Terrain.all[9].id)
EventTerrain.create!(event_id: Event.all[5].id, terrain_id: Terrain.all[7].id)
puts "Done!"

