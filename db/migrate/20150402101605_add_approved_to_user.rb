class AddApprovedToUser < ActiveRecord::Migration
  def change
    add_column :users, :approved, :boolean,:default => false
  end
end
