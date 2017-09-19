class CreateEventTerrains < ActiveRecord::Migration[5.1]
  def change
    create_table :event_terrains do |t|
      t.references :terrain, foreign_key: true
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
