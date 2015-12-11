class CreateStateCities < ActiveRecord::Migration
  def change
    create_table :state_cities do |t|
      t.string :state
      t.string :city

      t.timestamps null: false
    end
  end
end
