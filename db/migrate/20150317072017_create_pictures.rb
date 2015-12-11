class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :image
      t.string :imagiable_type
      t.integer :imagiable_id

      t.timestamps null: false
    end
  end
end
