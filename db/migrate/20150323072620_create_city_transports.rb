class CreateCityTransports < ActiveRecord::Migration
  def change
    create_table :city_transports do |t|
      t.references :package, index: true
      t.references :city, index: true
      t.string :city_name
      t.string :city_transpotation
      t.string :transport_mode

      t.timestamps null: false
    end
    add_foreign_key :city_transports, :packages
    add_foreign_key :city_transports, :cities
  end
end
