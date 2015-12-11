class AddApprovedToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :approved, :boolean,:default => false
  end
end
