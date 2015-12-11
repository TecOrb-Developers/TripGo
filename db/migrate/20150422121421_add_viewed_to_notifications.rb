class AddViewedToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :is_viewed, :boolean, default: false
    add_column :notifications, :message, :text, default: ''
  end
end
