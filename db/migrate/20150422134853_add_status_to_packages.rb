class AddStatusToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :status, :boolean, :default=> false
  end
end
