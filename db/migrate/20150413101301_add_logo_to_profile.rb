class AddLogoToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :logo, :string
  end
end
