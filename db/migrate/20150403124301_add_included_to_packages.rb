class AddIncludedToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :included, :string,array: true,:default => '{}'
  end
end
