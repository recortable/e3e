class CreateConsumptions < ActiveRecord::Migration
  def self.up
    create_table :consumptions do |t|
      t.string :service
      t.integer :ammount
      t.string :period
      t.references :user
      t.timestamps
    end

    add_index :consumptions, :service
    add_index :consumptions, :user_id
  end

  def self.down
    drop_table :consumptions
    remove_index :consumptions, :service
   remove_index :consumptions, :user_id
  end
end
