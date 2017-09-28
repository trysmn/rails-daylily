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


url = "https://raw.githubusercontent.com/ram-nadella/airport-codes/master/airports.json"

puts "Reading the json file..."
airports_file = open(url).read
puts "Done!"

puts "Storing the content of the json file in a hash..."
airports_hash = JSON.parse(airports_file)
puts "Done!"

puts "Seeding User..."
User.create(email: "one@localhost.dev", password: "one@localhost.dev", password_confirmation: "one@localhost.dev", admin: true)
puts "Done!"


puts "Creating all necessary airport cities..."
iata_codes_array = ["LON","PAR","MIL","BCN","BER","MAD","VIE","DUB","AMS","BRU","BSL","MUC","BUD","CPH","PRG"]
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
    end_time: Time.new(2017, 11, 5, 23, 0, 0),
    number_of_attendees: 10000,
    average_temp: 9,
    entrance_fee: 0,
    website: "http://2017.spiritsofmeath.com/",
    user_id: User.first.id,
    status: "approved",
    address: "Meath, Ireland",
    city_airport_id: CityAirport.all[7].id },

  { title: "Paris Nuit Blanche",
    description: "White Night, or Paris Nuit Blanche, is an annual art festival, offering visitors in the City of Light a unique cultural experience. Paris’s unrivaled museums, galleries, city halls, cinemas, swimming pools, and other entertainment and cultural institutions will be open (free of charge) to visitors until the early hours of the morning.",
    start_date: Date.parse('7th Oct 2017'),
    end_date: Date.parse('8th Oct 2017'),
    start_time: Time.new(2017, 10, 7, 19, 0, 0),
    end_time: Time.new(2017, 10, 8, 6, 0, 0),
    number_of_attendees: 200000,
    average_temp: 12,
    entrance_fee: 0,
    website: "http://quefaire.paris.fr/nuitblanche",
    user_id: User.first.id,
    status: "approved",
    address: "Paris, France",
    city_airport_id: CityAirport.all[1].id },

  { title: "Alba White Truffle Festival",
    description: "The city of Alba in Piedmont is the truffle capital of Italy, and each year the town celebrates its beloved produce with a plethora of entertaining events. Many concerts, food markets, races, sports, food fairs, cultural programs, and wine tasting opportunities offer visitors a one-of-a-kind cultural and culinary experience.",
    start_date: Date.parse('7th Oct 2017'),
    end_date: Date.parse('26th Nov 2017'),
    start_time: Time.new(2017, 10, 7, 9, 0, 0),
    end_time: Time.new(2017, 11, 26, 20, 0, 0),
    number_of_attendees: 20000,
    average_temp: 12,
    entrance_fee: 3,
    website: "http://www.fieradeltartufo.org/2016/en/evento/white-truffle-market/2-alba-white-truffle-market-albaqualita",
    user_id: User.first.id,
    status: "approved",
    address: "Alba, Italy",
    city_airport_id: CityAirport.all[2].id },

  { title: "Amsterdam Dance Event",
    description: "Amsterdam Dance Event, aka ADE, is not only the largest electronic club festival in the world, but also the foremost conference of its kind, where experts in the field discuss about the industry’s future. The festival features no less than 800 artists performing their absorbing sounds in fancy clubs across the city.",
    start_date: Date.parse('18th Oct 2017'),
    end_date: Date.parse('22nd Oct 2017'),
    start_time: Time.new(2017, 10, 18, 9, 0, 0),
    end_time: Time.new(2017, 10, 23, 5, 0, 0),
    number_of_attendees: 375000,
    average_temp: 12,
    entrance_fee: 300,
    website: "https://www.amsterdam-dance-event.nl/",
    user_id: User.first.id,
    status: "approved",
    address: "Amsterdam, Netherlands",
    city_airport_id: CityAirport.all[8].id },

  { title: "Copenhagen Culture Night",
    description: "Culture vultures, pay attention. Over 600 venues across the Danish capital are going to be dedicated to one evening of culture on October 9th. Highlights include dance shows, film screenings, circus performances, and more.",
    start_date: Date.parse('13th Oct 2017'),
    end_date: Date.parse('14th Oct 2017'),
    start_time: Time.new(2017, 10, 13, 18, 0, 0),
    end_time: Time.new(2017, 10, 14, 0, 0, 0),
    number_of_attendees: 10000,
    average_temp: 12,
    entrance_fee: 13,
    website: "https://www.kulturnatten.dk/en/Culture-night",
    user_id: User.first.id,
    status: "approved",
    address: "Copenhagen, Denmark",
    city_airport_id: CityAirport.all[13].id },

  { title: "Bloody Sexy Halloween",
    description: "Prague is another European city that gets into the swing of Halloween celebrations. There are several parties throughout the capital, but Bloody Sexy Halloween is the largest. Expect DJs, visual displays, pyrotechnics to take you late into the night.",
    start_date: Date.parse('28th Oct 2017'),
    end_date: Date.parse('29th Oct 2017'),
    start_time: Time.new(2017, 10, 28, 21, 0, 0),
    end_time: Time.new(2017, 10, 29, 5, 0, 0),
    number_of_attendees: 5000,
    average_temp: 11,
    entrance_fee: 15,
    website: "http://bloodysexy.cz/en/",
    user_id: User.first.id,
    status: "approved",
    address: "Prague, Czech Republic",
    city_airport_id: CityAirport.all[14].id } ]

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
    "http://www.discoverboynevalley.ie/sites/default/files/images/heritage-sites/Hill%20of%20Ward%20Torchlit%20Procession.jpg"],

  "Paris Nuit Blanche" => ["http://parislanuit.fr/wp-content/uploads/2015/09/mini-burble-paris-by-umbrellium-design-samsung-parvis-de-lhtel-de-ville-paris-nuit-blanche-2014-photo-by-united-states-of-paris-blog-980x480.jpg",
    "http://uk.france.fr/sites/default/files/imagecache/atf_slider_contentv2/nuit_blanche_2007_cparis_tourist_office_-_photographe_amelie_dupont_-_artiste_compagnie_carabosse_23.10.2017_0.jpg",
    "http://www.parisselectbook.com/wp-content/uploads/2013/09/blancnuit-gost.jpg",
    "http://mymodernmet.com/wp/wp-content/uploads/archive/JqOBFxOCA2ovczKWdyX1_1082107909.jpeg",
    "http://infos.parisattitude.com/wp-content/uploads/2014/03/Credit-Paris-Tourist-Office-Photographe-Amelie-Dupont.png"],

  "Alba White Truffle Festival" => ["http://www.winerist.com/images/uploads/Alba_1.jpg",
    "http://ef7031277fe0c33ee605-30321d5b89b5271d183a7187e68e2199.r77.cf5.rackcdn.com/wp-content/uploads/2014/10/1405608393.jpg",
    "http://www.fieradeltartufo.org/cgibin/2015/14537269804_gal.jpg",
    "http://static.fieradeltartufo.org/cgibin/2015/1495720768.jpg",
    "http://img.finedininglovers.com/?img=http%3A%2F%2Ffinedininglovers.cdn.crosscast-system.com%2FBlogPost%2FOriginal_11349_Tartuffo-bianco.jpg&w=1200&h=660&lu=1444556075&ext=.jpg"],

  "Amsterdam Dance Event" => ["http://cdn.relentlessbeats.com/wp-content/uploads/2015/10/amsterdam-dance-event-1200x573.jpg",
    "https://weraveyou.com/wp-content/uploads/2017/07/ADE.jpg",
    "http://www.creativeapplications.net/wp-content/uploads/2010/10/ADE-NEXT-Overview-credits-MikeBreeuwer.jpg",
    "https://i.ytimg.com/vi/w6JLlwCgIS0/maxresdefault.jpg",
    "http://46.32.240.39/globalpublicity.co.uk/wp-content/uploads/2012/10/20121019_Awakenings_-Rebekka_03.jpg"],

  "Copenhagen Culture Night" => ["http://www.cphmuseums.com/sites/default/files/styles/galleries_ratio/public/asp/cphmuseums/Artikler_ENG/Celebrate_Copenhagens_Culture_Night/designmuseum-til-web.gif?itok=549qLwiT",
    "http://www.cphmuseums.com/sites/default/files/styles/gallery_medium_width_mobile/public/asp/cphmuseums/Artikler_ENG/Celebrate_Copenhagens_Culture_Night/photo-pernille-klemp17.gif?itok=opiPWUOc",
    "http://www.thisweek.dk/wp-content/uploads/2015/10/PLAKAT_2015.png",
    "http://www.visitdenmark.co.uk/sites/default/files/VDK_Website_images/Tourist_content/Events/Festivals/culture-night-in-copenhagen.jpg",
    "https://ourwaytours.com/wp-content/uploads/Kulturnat_2012_687216a.jpg"],

  "Bloody Sexy Halloween" => ["http://www.forceproduction.eu/userfiles/photogallery/big/bloody-sexy-halloween__mi001-468.jpg",
    "https://i.ytimg.com/vi/12M_ebnu0Z0/maxresdefault.jpg",
    "http://www.forceproduction.eu/userfiles/photogallery/big/bloody-sexy-halloween__mi001-470.jpg",
    "http://travelcalendar.ru/wp-content/uploads/2015/08/Vecherinka-Bloody-Sexy-Halloween-v-Prage_glav1.jpg",
    "https://i.ytimg.com/vi/dB9emuHa9yM/maxresdefault.jpg"]
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
EventCategory.create!(event_id: Event.all[0].id, category_id: Category.all[2].id)
EventCategory.create!(event_id: Event.all[1].id, category_id: Category.all[6].id)
EventCategory.create!(event_id: Event.all[2].id, category_id: Category.all[6].id)
EventCategory.create!(event_id: Event.all[3].id, category_id: Category.all[0].id)
EventCategory.create!(event_id: Event.all[4].id, category_id: Category.all[9].id)
EventCategory.create!(event_id: Event.all[5].id, category_id: Category.all[0].id)
EventCategory.create!(event_id: Event.all[6].id, category_id: Category.all[0].id)
EventCategory.create!(event_id: Event.all[7].id, category_id: Category.all[1].id)
EventCategory.create!(event_id: Event.all[8].id, category_id: Category.all[9].id)
EventCategory.create!(event_id: Event.all[9].id, category_id: Category.all[9].id)
puts "Done!"

puts "Adding terrains to each event..."
EventTerrain.create!(event_id: Event.all[0].id, terrain_id: Terrain.all[9].id)
EventTerrain.create!(event_id: Event.all[1].id, terrain_id: Terrain.all[9].id)
EventTerrain.create!(event_id: Event.all[2].id, terrain_id: Terrain.all[9].id)
EventTerrain.create!(event_id: Event.all[3].id, terrain_id: Terrain.all[9].id)
EventTerrain.create!(event_id: Event.all[4].id, terrain_id: Terrain.all[1].id)
EventTerrain.create!(event_id: Event.all[5].id, terrain_id: Terrain.all[9].id)
EventTerrain.create!(event_id: Event.all[6].id, terrain_id: Terrain.all[9].id)
EventTerrain.create!(event_id: Event.all[6].id, terrain_id: Terrain.all[9].id)
EventTerrain.create!(event_id: Event.all[7].id, terrain_id: Terrain.all[9].id)
EventTerrain.create!(event_id: Event.all[8].id, terrain_id: Terrain.all[9].id)
EventTerrain.create!(event_id: Event.all[9].id, terrain_id: Terrain.all[9].id)
puts "Done!"


