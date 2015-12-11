class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.references :package, index: true
      t.integer :number_of_days
      t.string :hotel_name,null: false, default: ""
      t.text :hotel_address,null: false, default: ""
      t.string :rating,null: false, default: ""
      t.string :hotel_amenities,array: true,:default => '{}'
      t.string :room_type,null: false, default: ""
      t.string :room_amenities,array: true,:default => '{}'

      t.timestamps null: false
    end
    add_foreign_key :hotels, :packages
  end
end
