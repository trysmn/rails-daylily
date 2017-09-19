class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :photos
      t.date :start_date
      t.date :end_date
      t.time :start_time
      t.time :end_time
      t.integer :number_of_attendees
      t.integer :average_temp
      t.integer :entrance_fee
      t.string :website
      t.float :latitude
      t.float :longitude
      t.references :user, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
