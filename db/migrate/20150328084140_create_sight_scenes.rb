class CreateSightScenes < ActiveRecord::Migration
  def change
    create_table :sight_scenes do |t|
      t.references :package, index: true
      t.string :included, :defalult => "included"
      t.string :sight_scene
      t.string :guide
      t.string :destination
      t.string :description
      t.string :picture

      t.timestamps null: false
    end
    add_foreign_key :sight_scenes, :packages
  end
end
