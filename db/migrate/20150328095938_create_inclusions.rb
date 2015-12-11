class CreateInclusions < ActiveRecord::Migration
  def change
    create_table :inclusions do |t|
      t.references :package, index: true
      t.text :exclusion,              null: false, default: ""
      t.text :conditions,              null: false, default: ""
      t.text :cancallation_policy,              null: false, default: ""
      t.text :extra,              null: false, default: ""

      t.timestamps null: false
    end
    add_foreign_key :inclusions, :packages
  end
end
