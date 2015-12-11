class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.text :content
      t.string :send_to
      t.references :admin_user, index: true

      t.timestamps null: false
    end
    add_foreign_key :offers, :admin_users
  end
end
