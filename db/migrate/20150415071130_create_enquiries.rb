class CreateEnquiries < ActiveRecord::Migration
  def change
    create_table :enquiries do |t|
      t.references :user, index: true
      t.references :package, index: true
      t.string :name
      t.string :phone_no
      t.string :email
      t.string :custome_travel
      t.string :custome_hotel
      t.string :custome_local_transport
      t.string :custome_meals
      t.string :custome_sights

      t.timestamps null: false
    end
    add_foreign_key :enquiries, :users
    add_foreign_key :enquiries, :packages
  end
end
