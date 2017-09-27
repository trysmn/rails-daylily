# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'json'

puts "Deleting all current terrains..."
Terrain.destroy_all
puts "Done!"

puts "Deleting all current categories..."
Category.destroy_all
puts "Done!"

puts "Deleting all search details..."
SearchDetail.destroy_all
puts "Done!"

puts "Deleting all current events..."
Event.destroy_all
puts "Done!"

puts "Deleting all current users..."
User.destroy_all
puts "Done!"

puts "Deleting all current airport cities..."
CityAirport.destroy_all
puts "Done!"

# puts "Deleting all current event_categories..."
# EventCategory.destroy_all
# puts "Done!"

# puts "Deleting all current event_terrains..."
# EventTerrain.destroy_all
# puts "Done!"

url = "https://raw.githubusercontent.com/ram-nadella/airport-codes/master/airports.json"

puts "Reading the json file..."
airports_file = open(url).read
puts "Done!"

puts "Storing the content of the json file in a hash..."
airports_hash = JSON.parse(airports_file)
puts "Done!"

puts "Seeding User..."
User.create(email: "one@localhost.dev", password: "one@localhost.dev", password_confirmation: "one@localhost.dev")
puts "Done!"


puts "Creating all necessary airport cities..."
iata_codes_array = ["LON","PAR","MIL","BCN","BER","MAD","VIE","DUB","AMS","BRU","BSL","MUC","BUD"]
iata_codes_array.each do |iata,index|
  CityAirport.create!(city_name: airports_hash[iata]["city"], iata_code: airports_hash[iata]["iata"])
end
puts "Done!"

puts "Seeding categories..."
categories_array = ["Food","Music","Beer","Cocktail","Sport","Book","Art/Design","Film","Wine","Theme"]
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

events_array = [
#   { title: "London Cocktail Week",
  #   description: "Join a seven-day cocktail party celebrating the capital's top bars, mixologists and cocktail scene during London Cocktail Week (LCW). Hosted by DrinkUp.London, the same team behind London Beer Week and Wine Week, the annual festival features a vibrant cocktail village as well as special offers at more than 250 bars, restaurants and pop-ups all…",
  #   start_date: Date.parse('2nd Oct 2017'),
  #   end_date: Date.parse('8th Oct 2017'),
  #   average_temp: 12,
  #   entrance_fee: 0,
  #   website: "https://drinkup.london/cocktailweek/",
  #   user_id: User.first,
  #   status: "approved",
  #   address: "16 Horner Square, London E1 6EW, UK",
  #   city_airport_id: CityAirport.first.id },

#   { title: "Frieze Sculpture park",
#     description: "Wander through a stunning outdoor exhibition featuring works by some of the world’s most famous sculptors with Frieze Sculpture 2017 in Regent’s Park's English Gardens. Bringing together 25 sculptures by acclaimed 20th-century and contemporary artists, Frieze Sculpture is a great way to get a taste of Frieze Masters and Frieze London, before…",
#     start_date: Date.parse('2th Oct 2017'),
#     end_date: Date.parse('8th Oct 2017'),
#     average_temp: 12,
#     entrance_fee: 0,
#     website: "https://frieze.com/article/frieze-sculpture-2017-0",
#     user_id: User.first,
#     status: "approved",
#     address: "Chester Rd, London NW1 4NR, UK",
#     city_airport_id: CityAirport.first.id },

#   { title: "Cinekid Festival",
#     description: "The Cinekid Festival is an annual film, television and new-media festival for children across the Netherlands, attended by more than 50,000 children and (international) guests every year. The festival traditionally takes place at Amsterdam’s Westergasfabriek in September or October, around the autumn school holidays.",
#     start_date: Date.parse('21st Oct 2017'),
#     end_date: Date.parse('23rd Oct 2017'),
#     average_temp: 13,
#     entrance_fee: 0,
#     website: "https://www.cinekid.nl/english/festival",
#     user_id: User.first,
#     status: "approved",
#     address: "Kattenburgerstraat 5, 1018 JA Amsterdam, Netherlands",
#     city_airport_id: CityAirport.all[8].id },

#   { title: "Read My World",
#     description: "Read My World is the international literature festival of Amsterdam. Going beyond the commonplace, it explores the boundaries of literature and journalism and draws attention to everything in between. It traditionally takes place in October at the Tolhuistuin.",
#     start_date: Date.parse('12th Oct 2017'),
#     end_date: Date.parse('14th Oct 2017'),
#     start_time: Time.new(2017, 10, 12, 10, 0, 0),
#     end_time: Time.new(2017, 10, 14, 16, 0, 0),
#     average_temp: 13,
#     entrance_fee: 15,
#     website: "http://www.readmyworld.nl/tickets/",
#     user_id: User.first,
#     status: "approved",
#     address: "Amsterdam, Netherlands",
#     city_airport_id: CityAirport.all[8].id },

#   { title: "Barcelona Wine and Cava Festival",
#     description: "The Mostra de Vins i Caves de Catalunya is once again at the Arc de Triomf monument on Passeig de Lluis Company.  Taking part are over 70 top wineries present wines from 12 Catalan denominations of origin including DO Alella, Catalonia, Cava, Conca de Barbera, Costers del Segre, Empordà Montsant Penedès Pla de Bages, Priorat, Tarragona and Terra…",
#     start_date: Date.parse('27th Oct 2017'),
#     end_date: Date.parse('29th Oct 2017'),
#     start_time: Time.new(2017, 10, 27, 12, 0, 0),
#     end_time: Time.new(2017, 10, 29, 20, 0, 0),
#     average_temp: 21,
#     entrance_fee: 0,
#     website: "http://www.barcelonayellow.com/bcn-events-calendar/details/761-merce-wine-and-cava-festival",
#     user_id: User.first,
#     status: "approved",
#     address: "Passeig de Lluís Companys, 08003, Barcelona, Spain",
#     city_airport_id: CityAirport.all[3].id },

#   { title: "Barcelona Boat Show",
#     description: "The 2017 Barcelona Boat Show welcomes you to the 55th edition. Barcelona boat show is a 5 day boat show with over 300 Spanish and foreign exhibitors, around 700 boats and more than 1,300 sailors taking part in the annual Catalan Sailing Week. The Barcelona boat show is a floating boat show in Barcelona's marina the Port Vell marina with more than…",
#     start_date: Date.parse('11th Oct 2017'),
#     end_date: Date.parse('15th Oct 2017'),
#     start_time: Time.new(2017, 10, 11, 10, 0, 0),
#     end_time: Time.new(2017, 10, 15, 19, 0, 0),
#     average_temp: 21,
#     entrance_fee: 0,
#     website: "http://www.barcelonayellow.com/bcn-events-calendar/details/89-barcelona-boat-show-salon-nautico",
#     user_id: User.first,
#     status: "approved",
#     address: "Carrer de l'Escar, 26, 08039 Barcelona",
#     city_airport_id: CityAirport.all[3].id },

  { title: "Oktoberfest",
    description: "Most of Oktoberfest actually takes place in September, but you can still catch the last few days of this famous event. It’s the world’s largest beer festival, which should be enough to have you packing your bags. But it’s also an extravaganza of German food, culture, and revelry. Book early to avoid disappointment.",
    start_date: Date.parse('16th Sep 2017'),
    end_date: Date.parse('3rd Oct 2017'),
    start_time: Time.new(2017, 9, 16, 10, 0, 0),
    end_time: Time.new(2017, 10, 3, 23, 30, 0),
    number_of_attendees: 6000000,
    average_temp: 10,
    entrance_fee: 0,
    website: "https://www.oktoberfest.de/en/",
    user_id: User.first.id,
    status: "approved",
    address: "Munich, Germany",
    city_airport_id: CityAirport.all[11].id },

  { title: "Berlin Festival of Lights",
    description: "All major monuments in the city light up to celebrate the spectacular Festival of Lights. There are local and international artists presenting light installations that tell stories and highlight the city’s fascinating history. The light reaches streets, squares, and trendy neighborhoods across the city, making it a beautiful time to visit Berlin.",
    start_date: Date.parse('6th Oct 2017'),
    end_date: Date.parse('15th Oct 2017'),
    start_time: Time.new(2017, 10, 6, 18, 0, 0),
    end_time: Time.new(2017, 10, 15, 23, 30, 0),
    number_of_attendees: 2000000,
    average_temp: 10,
    entrance_fee: 0,
    website: "http://festival-of-lights.de/en/",
    user_id: User.first.id,
    status: "approved",
    address: "Berlin, Germany",
    city_airport_id: CityAirport.all[4].id },

  { title: "Café Budapest Contemporary Arts Festival",
    description: "It’s a fantastic time to experience Budapest. There’s a full program on offer that features jazz, dance, theater, poetry, fine arts, and Fashion Week. The festival is now in its 26th year, and shows no signs of letting up.",
    start_date: Date.parse('6th Oct 2017'),
    end_date: Date.parse('22nd Oct 2017'),
    start_time: Time.new(2017, 10, 6, 10, 0, 0),
    end_time: Time.new(2017, 10, 22, 22, 0, 0),
    number_of_attendees: 500000,
    average_temp: 12,
    entrance_fee: 10,
    website: "https://www.cafebudapestfest.hu/events",
    user_id: User.first.id,
    status: "approved",
    address: "Budapest, Hungary",
    city_airport_id: CityAirport.all[12].id },

  { title: "Eurochocolate Festival",
    description: "Italy may mainly be about pizzas and pasta, but the Umbrian capital of Perugia also knows all about chocolate. Aside from satisfying even the most demanding sweet tooth, you’ll also get to see some remarkable chocolate displays, attend workshops, and listen to some of the world’s best chocolatiers waxing lyrical about their trade.",
    start_date: Date.parse('13th Oct 2017'),
    end_date: Date.parse('24th Oct 2017'),
    start_time: Time.new(2017, 10, 13, 9, 0, 0),
    end_time: Time.new(2017, 10, 24, 17, 0, 0),
    number_of_attendees: 1000000,
    average_temp: 13,
    entrance_fee: 0,
    website: "http://www.wheremilan.com/events/eurochocolate-festival-2017-perugia-450km-milan/",
    user_id: User.first.id,
    status: "approved",
    address: "Perugia, Italy",
    city_airport_id: CityAirport.all[2].id },

  { title: "Spirits of Meath Halloween Festival",
    description: "Some say that Halloween started in this small Irish county. If you’re a fan of celebrating this spooky holiday, then this should be your first stop. There’s a range of events throughout the region, and most visitors get into the spirit by dressing up.",
    start_date: Date.parse('13th Oct 2017'),
    end_date: Date.parse('6th Nov 2017'),
    start_time: Time.new(2017, 10, 13, 18, 0, 0),
    end_time: Time.new(2017, 11, 6, 23, 0, 0),
    number_of_attendees: 10000,
    average_temp: 9,
    entrance_fee: 0,
    website: "http://2017.spiritsofmeath.com/",
    user_id: User.first.id,
    status: "approved",
    address: "Meath, Ireland",
    city_airport_id: CityAirport.all[7].id }, ]

urls = {
  "Oktoberfest" => ["http://static4.businessinsider.com/image/55fb1b179dd7cc17008bb316-1190-625/im-from-munich-and-heres-why-i-think-you-should-avoid-oktoberfest.jpg",
    "https://media.cntraveler.com/photos/55fc1d92f6c571a37180a60a/master/pass/oktoberfest-munich-hacker-pschorr-cr-gallery-stock.jpg",
    "https://static1.squarespace.com/static/534f11ffe4b0cd2bba388df7/575ef4e7f8baf34c35fac3a7/575ef4ea746fb98f3ac7b3be/1465840875708/zum-schneider-nyc-2014-oktoberfest-munich-east-river-5958.jpg?format=750w",
    "http://lh3.ggpht.com/-SkB_zaZqNI8/UGG0yh2_I7I/AAAAAAAAdxE/ahxdCxyLbvw/oktoberfest-2012-31%25255B6%25255D.jpg?imgmax=800",
    "http://www.lonelyplanet.com/news/wp-content/uploads/2017/06/tent-at-oktoberfest.jpg"],

  "Berlin Festival of Lights" => ["http://www.circus-berlin.de/blog/wp-content/uploads/2015/10/10646702765_e23e03328f_o.jpg",
    "http://awesomeberlin.net/wp-content/uploads/2016/10/lights3.jpg",
    "http://magazine.magix.com/en/wp-content/uploads/sites/3/2010/10/festival_of_lights_berliner-dom.jpg",
    "http://festival-of-lights.de/wp-content/uploads/2016/10/29667574764_be708527b4_b.jpg",
    "http://awesomeberlin.net/wp-content/uploads/2016/10/lights1.jpg"],

  "Café Budapest Contemporary Arts Festival" => ["https://www.cafebudapestfest.hu/pic/og-logo-v2016-2-hu.png",
    "https://static1.squarespace.com/static/53ad8891e4b0d11d5eacd15a/583edc80579fb3beb58d162a/583edc93579fb3beb58d1713/1480514746289/hellodesign-cafefesztival-15.jpg",
    "http://gobudapest.com/wp-content/uploads/2015/09/caf%C3%A9-2.jpg",
    "https://dailynewshungary.com/wp-content/uploads/2017/05/jewish-festival-980x640.jpg",
    "https://res.cloudinary.com/rebbix/image/upload/f_auto,q_auto/fl_progressive.force_strip,w_970/qssycghoqq841qpsyvch"],

  "Eurochocolate Festival" => ["https://www.carnifest.com/image/49962105/euro_chocolate_.jpg",
    "http://www.italybyevents.com/wp-content/uploads/2016/09/Eurochocolate-Perugia-1.jpg",
    "https://d3rr2gvhjw0wwy.cloudfront.net/uploads/activity_headers/215/1500x1500-0-70-981898627def23f6daa6e1615fcc0b72.jpg",
    "https://i.pinimg.com/736x/66/52/3b/66523bdec5ad83342d6a13c44235fcf7--chocolate-festival-perugia-italy.jpg",
    "https://www.eurochocolate.net/wp-content/uploads/2016/09/eurochocolate-eventi.jpg"],

  "Spirits of Meath Halloween Festival" => ["https://yellow.place/file/image/cover/0/0/86/figkwskkrvfgymmk.jpg",
    "https://www.irishtimes.com/polopoly_fs/1.2403249.1445599206!/image/image.jpg",
    "http://www.independent.ie/editorial/StoryPlus/storyplus-there-is-something-special-about-irelands-ancient-east-at-halloween/media/festival_of_fire-mr.jpg",
    "http://vibrantireland.com/wp-content/uploads/2015/10/halloween-ireland-spirits-of-meath-by-barry-cronin.jpg",
    "http://www.discoverboynevalley.ie/sites/default/files/images/heritage-sites/Hill%20of%20Ward%20Torchlit%20Procession.jpg"]
}

events_array.each do |event|
  puts "Creating event..."
  new_event = Event.create!(event)
  puts "Done!"
  puts "Adding relevant photos to that event..."
  new_event.photo_urls = urls[new_event.title]
  puts "Done!"
end
puts "Done!"

puts "Adding a category to each event..."
# EventCategory.create!(event_id: Event.first.id, category_id: Category.all[3].id)
# EventCategory.create!(event_id: Event.all[1].id, category_id: Category.all[6].id)
# EventCategory.create!(event_id: Event.all[2].id, category_id: Category.all[7].id)
# EventCategory.create!(event_id: Event.all[3].id, category_id: Category.all[5].id)
# EventCategory.create!(event_id: Event.all[4].id, category_id: Category.all[8].id)
# EventCategory.create!(event_id: Event.all[5].id, category_id: Category.all[4].id)
EventCategory.create!(event_id: Event.all[0].id, category_id: Category.all[2].id)
EventCategory.create!(event_id: Event.all[1].id, category_id: Category.all[6].id)
EventCategory.create!(event_id: Event.all[2].id, category_id: Category.all[6].id)
EventCategory.create!(event_id: Event.all[3].id, category_id: Category.all[0].id)
EventCategory.create!(event_id: Event.all[4].id, category_id: Category.all[9].id)
puts "Done!"

puts "Adding terrains to each event..."
# EventTerrain.create!(event_id: Event.first.id, terrain_id: Terrain.all[9].id)
# EventTerrain.create!(event_id: Event.all[1].id, terrain_id: Terrain.all[12].id)
# EventTerrain.create!(event_id: Event.all[2].id, terrain_id: Terrain.all[9].id)
# EventTerrain.create!(event_id: Event.all[3].id, terrain_id: Terrain.all[9].id)
# EventTerrain.create!(event_id: Event.all[4].id, terrain_id: Terrain.all[9].id)
# EventTerrain.create!(event_id: Event.all[5].id, terrain_id: Terrain.all[7].id)
EventTerrain.create!(event_id: Event.all[0].id, terrain_id: Terrain.all[9].id)
EventTerrain.create!(event_id: Event.all[1].id, terrain_id: Terrain.all[9].id)
EventTerrain.create!(event_id: Event.all[2].id, terrain_id: Terrain.all[9].id)
EventTerrain.create!(event_id: Event.all[3].id, terrain_id: Terrain.all[9].id)
EventTerrain.create!(event_id: Event.all[4].id, terrain_id: Terrain.all[1].id)
puts "Done!"


