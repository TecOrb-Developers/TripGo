class AddRecommendedSideAndRecommendedCenterToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :recommended_side, :boolean,default: false
    add_column :packages, :recommended_center, :boolean,default: false
  end
end
