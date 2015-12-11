class CreateMeals < ActiveRecord::Migration
	def change
		create_table :meals do |t|
			t.references :package, index: true
			t.string :meal_type
			t.string :meal_description, :default => ""

			t.timestamps null: false
		end
		add_foreign_key :meals, :packages
	end
end
