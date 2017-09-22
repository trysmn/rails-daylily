class Event < ApplicationRecord
  belongs_to :city_airport

  has_many :event_terrains
  has_many :terrains, through: :event_terrains

  has_many :event_categories
  has_many :categories, through: :event_categories

  has_attachments :photos, maximum: 5

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
