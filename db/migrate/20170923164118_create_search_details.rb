class CreateSearchDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :search_details do |t|
      t.references :city_airport, foreign_key: true
      t.date :departure_date
      t.date :return_date
      t.json :incoming_data

      t.timestamps
    end
  end
end
