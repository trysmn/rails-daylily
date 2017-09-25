class Terrain < ApplicationRecord
  has_many :event_terrains, dependent: :destroy
  has_many :events, through: :event_terrains
end
