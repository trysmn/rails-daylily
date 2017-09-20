class AddAirportToEvents < ActiveRecord::Migration[5.0]
  def change
    add_reference :events, :city_airport, foreign_key: true
  end
end
