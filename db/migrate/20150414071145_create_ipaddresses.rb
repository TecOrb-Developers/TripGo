class CreateIpaddresses < ActiveRecord::Migration
  def change
    create_table :ipaddresses do |t|
      t.string :ip_address

      t.timestamps null: false
    end
  end
end
