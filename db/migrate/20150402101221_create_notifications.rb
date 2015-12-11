class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :notifiable_type
      t.integer :notifiable_id
      t.string :action_type
      t.integer :sender
      t.integer :reciever

      t.timestamps null: false
    end
  end
end
