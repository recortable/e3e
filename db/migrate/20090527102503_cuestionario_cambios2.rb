class CuestionarioCambios2 < ActiveRecord::Migration
  def self.up
    rename_column :surveys, :equip_agua_tipo, :equip_agua_disp
    rename_column :surveys, :equip_agua_caldera_tipo, :equip_agua_tipo
    remove_column :surveys, :equip_agua_caliente
  end

  def self.down
    rename_column :surveys, :equip_agua_tipo, :equip_agua_caldera_tipo
    rename_column :surveys, :equip_agua_disp, :equip_agua_tipo
    add_column :surveys, :equip_agua_caliente, :string
  end
end
