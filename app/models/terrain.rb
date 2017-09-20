class Terrain < ApplicationRecord
  has_many :event_terrains
  has_many :events, through: :event_terrains
end
