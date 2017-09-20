class CreateCityAirports < ActiveRecord::Migration[5.0]
  def change
    create_table :city_airports do |t|
      t.string :city_name
      t.string :iata_code

      t.timestamps
    end
  end
end
