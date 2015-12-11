class CreateComplaints < ActiveRecord::Migration
  def change
    create_table :complaints do |t|
      t.string :name
      t.string :email
      t.string :contact_no
      t.string :category
      t.string :subject
      t.text :message

      t.timestamps null: false
    end
  end
end
