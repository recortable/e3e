class CuestionarioCambios2 < ActiveRecord::Migration
  def self.up
    rename_column :survey, :equip_agua_tipo, :equip_agua_disp
    rename_column :survey, :equip_agua_caldera_tipo, :equip_agua_tipo
    delete_column :survey, :equip_agua_caliente
  end

  def self.down
    rename_column :survey, :equip_agua_tipo, :equip_agua_caldera_tipo
  end
end
