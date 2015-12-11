class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.references :user, index: true
      t.string :itinerary_name   ,null: false, default: ""
      t.string :holidays         ,array: true,:default => '{}'
      t.string :holiday_types    ,array: true,:default => '{}'
      t.float :price_per_person  ,null: false, default: 0
      t.string :room_sharing     ,null: false, default: ""
      t.boolean :extra_room      ,default: false
      t.float :extra_cost        ,null: false,default: 0 
      t.string :package_duration ,null: false, default: ""
      t.boolean :tag_as_weakend   
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
    add_foreign_key :packages, :users
  end
end
