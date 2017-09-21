# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Deleting all current event_categories"
EventCategory.destroy_all

puts "Deleting all current event_terrains"
EventTerrain.destroy_all

puts "Deleting all current categories"
Category.destroy_all

puts "Seeding categories"
Category.create!([{ name: "Food" }, { name: "Wine" }, { name: "Music" }, { name: "Beer" }, { name: "Sport" }])


puts "Deleting all current terrains"
Terrain.destroy_all

puts "Seeding terrains"
Terrain.create!([{ name: "Desert" }, { name: "Forest" }, { name: "Grassland" }, { name: "Hills" }, { name: "Jungle" }, { name: "Mountain" }, { name: "Plain" }, { name: "River" }, { name: "Tundra" }, { name: "Urban" }, { name: "Rural" },  { name: "Beach" }])


puts "Deleting all current events"
Event.destroy_all

puts "Seeding events"
event1 = Event.new(
  title: "Gracia Festival",
  description: "The Festivities of Gracia or Major Festival of Gracia (in Catalan , Festa Major de Gràcia ) is a popular celebration celebrated in the district of Gracia of Barcelona from 15 of August and by a term of between seven and ten days. Its most distinctive element is the ornamentation of streets, but also concerts, popular dances, castellan exhibitions , giants and cabezudos , correfocs of devils and dragons of fire, bastoners , trabucaires and other festive and religious events, like the mass in honor to Our Lady of Grace.",
  user_id: 1)
event2 = Event.new(
  title: "Kingsday Festival",
  description: "Koningsdag is known for its nationwide vrijmarkt free market, at which the Dutch sell their used items. It is also an opportunity for orange madness or oranjegekte, a kind of frenzy named for the national colour.",
  user_id: 1)

event1.save!
event2.save!

puts "Adding categories to events"

EventCategory.create!(event_id: Event.first.id, category_id: Category.first.id)
EventCategory.create!(event_id: Event.first.id, category_id: Category.second.id)
EventCategory.create!(event_id: Event.last.id, category_id: Category.last.id)
EventCategory.create!(event_id: Event.last.id, category_id: Category.second.id)

puts "Adding terrains to events"

TerrainCategory.create!(event_id: Event.first.id, terrain_id: Terrain.first.id)
TerrainCategory.create!(event_id: Event.first.id, terrain_id: Terrain.second.id)
TerrainCategory.create!(event_id: Event.last.id, terrain_id: Terrain.last.id)
TerrainCategory.create!(event_id: Event.last.id, terrain_id: Terrain.second.id)
