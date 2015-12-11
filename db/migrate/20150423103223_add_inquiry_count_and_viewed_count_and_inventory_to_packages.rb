class AddInquiryCountAndViewedCountAndInventoryToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :inquiry_count, :integer, default: 0
    add_column :packages, :viewed_count, :integer, default: 0
    add_column :packages, :inventory, :string, default: ''
  end
end
