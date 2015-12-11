class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.references :package, index: true
      t.string :city_name,null: false, default: ""

      t.timestamps null: false
    end
    add_foreign_key :cities, :packages
  end
end
