class AddInvoiceScaleToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :invoice_scale_max, :integer, :default => 2000
  end

  def self.down
    remove_column :users, :invoice_scale_max
  end
end
