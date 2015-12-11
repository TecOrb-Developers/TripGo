class CreateItineraries < ActiveRecord::Migration
  def change
    create_table :itineraries do |t|
      t.references :package, index: true
      t.string :description
      t.string :picture

      t.timestamps null: false
    end
    add_foreign_key :itineraries, :packages
  end
end
