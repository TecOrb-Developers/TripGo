class CreateCrms < ActiveRecord::Migration
  def change
    create_table :crms do |t|
      t.references :user, index: true
      t.references :package, index: true
      t.string :name
      t.string :destination
      t.date :visit_date
      t.string :start_from
      t.string :assigned_to
      t.string :visit_for
      t.boolean :is_customize_request
      t.string :status

      t.timestamps null: false
    end
    add_foreign_key :crms, :users
    add_foreign_key :crms, :packages
  end
end
