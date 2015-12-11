class CreateWishlists < ActiveRecord::Migration
  def change
    create_table :wishlists do |t|
      t.references :user, index: true
      t.integer :package_id, index: true

      t.timestamps null: false
    end
    add_foreign_key :wishlists, :users
  end
end
