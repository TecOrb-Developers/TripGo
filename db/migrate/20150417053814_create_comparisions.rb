class CreateComparisions < ActiveRecord::Migration
  def change
    create_table :comparisions do |t|
      t.references :user, index: true
      t.references :package, index: true

      t.timestamps null: false
    end
    add_foreign_key :comparisions, :users
    add_foreign_key :comparisions, :packages
  end
end
