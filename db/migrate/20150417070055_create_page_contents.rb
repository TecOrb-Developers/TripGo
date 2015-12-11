class CreatePageContents < ActiveRecord::Migration
  def change
    create_table :page_contents do |t|
      t.string :page
      t.string :title
      t.string :content

      t.timestamps null: false
    end
  end
end
