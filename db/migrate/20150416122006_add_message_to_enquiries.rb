class AddMessageToEnquiries < ActiveRecord::Migration
  def change
    add_column :enquiries, :message, :text
  end
end
