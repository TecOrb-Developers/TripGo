class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true
      t.string :agency_name,              null: false, default: ""
      t.string :based_out_of,              null: false, default: ""
      t.text :head_office_address,              null: false, default: ""
      t.text :branch_location,              null: false, default: ""
      t.string :website_name,              null: false, default: ""
      t.text :travel_association_reference_no,              null: false, default: ""
      t.text :about_us,              null: false, default: ""
      t.string :fb_profile_page,              null: false, default: ""
      t.string :ln_profile_page,              null: false, default: ""
      t.string :twitter_profile_page,              null: false, default: ""
      t.text :tour_locations,            :default => ""
      t.text :category,               array: true,:default => '{}'
      t.text :awards,              null: false, default: ""
      t.text :specilized_in,               array: true,:default => '{}'
      t.timestamps null: false
    end
    add_foreign_key :profiles, :users
  end
end
