class CreateTransports < ActiveRecord::Migration
  def change
    create_table :transports do |t|
      t.references :package, index: true
      t.string :transport_mode
      t.string :transport_name
      t.string :start
      t.string :end
      t.string :transfer_section
      t.string :transfer_mode
      t.string :time_of_onward ,array: true,:default => '{}'


      t.timestamps null: false
    end
    add_foreign_key :transports, :packages
  end
end
