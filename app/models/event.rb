class Event < ApplicationRecord
  belongs_to :user

  has_many :event_categories
  has_many :categories, through: :event_categories

  has_many :event_terrains
  has_many :terrains, through: :event_terrains
end
