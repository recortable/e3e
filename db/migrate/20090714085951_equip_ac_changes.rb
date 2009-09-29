class EquipAcChanges < ActiveRecord::Migration
  def self.up
    add_column :surveys, :equip_ac_individual_tipo, :string, :lenght => 8
    add_column :surveys, :equip_ac_indepe_tipo, :string, :length => 8
  end

  def self.down
    remove_column :surveys, :equip_ac_individual_tipo
    remove_column :surveys, :equip_ac_indepe_tipo
  end
end
