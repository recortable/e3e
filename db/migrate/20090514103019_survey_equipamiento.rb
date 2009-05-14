class SurveyEquipamiento < ActiveRecord::Migration
  def self.up
    Survey::EQUIP_SERVICIOS.each do |serv|
      Survey::EQUIP_FUENTES.each do |source|
        add_column :surveys, "equip_fuentes_#{serv}_#{source}", :boolean
      end
    end

    add_column :surveys, :equip_agua_caliente, :string, :limit => 3
    add_column :surveys, :equip_agua_tipo, :string, :limit => 8
    add_column :surveys, :equip_agua_solar, :string, :limit => 3
    add_column :surveys, :equip_agua_edad, :integer, :limit => 3
    add_column :surveys, :equip_agua_caldera_tipo, :string, :limit => 8
    add_column :surveys, :equip_agua_caldera_acumulacion, :string, :limit => 3

    add_column :surveys, :equip_calefaccion, :string, :limit => 3
    add_column :surveys, :equip_calefaccion_tipo, :string, :limit => 8
    Survey::EQUIP_DONDE.each do |donde|
      add_column :surveys, "equip_calefaccion_donde_#{donde}", :string, :limit => 8
    end
    add_column :surveys, :equip_calefaccion_edad, :integer, :limit => 3
    add_column :surveys, :equip_calefaccion_misma, :string, :limit => 3
    add_column :surveys, :equip_calefaccion_caldera_tipo, :string, :limit => 8
    add_column :surveys, :equip_calefaccion_bomba_tipo, :string, :limit => 8


    add_column :surveys, :equip_ac, :string, :limit => 3
    Survey::EQUIP_DONDE.each do |donde|
      add_column :surveys, "equip_ac_donde_#{donde}", :string, :limit => 8
    end
    add_column :surveys, :equip_ac_tipo, :string, :limit => 8
    add_column :surveys, :equip_ac_edad, :integer, :limit => 3

    Survey::EQUIP_DISPOSITIVOS.each do |disp|
      add_column :surveys, "equip_disp_tiene_#{disp}", :integer
    end

    Survey::EQUIP_ILUMINACION.each do |disp|
      add_column :surveys, "equip_ilum_tiene_#{disp}", :integer
    end
  end


  def self.down
    Survey::EQUIP_SERVICIOS.each do |serv|
      Survey::EQUIP_FUENTES.each do |source|
        remove_column :surveys, "equip_fuentes_#{serv}_#{source}"
      end
    end

    remove_column :surveys, :equip_agua_caliente
    remove_column :surveys, :equip_agua_tipo
    remove_column :surveys, :equip_agua_solar
    remove_column :surveys, :equip_agua_edad
    remove_column :surveys, :equip_agua_caldera_tipo
    remove_column :surveys, :equip_agua_caldera_acumulacion

    remove_column :surveys, :equip_calefaccion
    remove_column :surveys, :equip_calefaccion_tipo
    Survey::EQUIP_DONDE.each do |donde|
      remove_column :surveys, "equip_calefaccion_donde_#{donde}", :string, :limit => 8
    end
    remove_column :surveys, :equip_calefaccion_edad
    remove_column :surveys, :equip_calefaccion_misma
    remove_column :surveys, :equip_calefaccion_caldera_tipo
    remove_column :surveys, :equip_calefaccion_bomba_tipo

    remove_column :surveys, :equip_ac, :string
    Survey::EQUIP_DONDE.each do |donde|
      remove_column :surveys, "equip_ac_donde_#{donde}", :string, :limit => 8
    end
    remove_column :surveys, :equip_ac_tipo
    remove_column :surveys, :equip_ac_edad

    Survey::EQUIP_DISPOSITIVOS.each do |disp|
      remove_column :surveys, "equip_disp_tiene_#{disp}"
    end

    Survey::EQUIP_ILUMINACION.each do |disp|
      remove_column :surveys, "equip_ilum_tiene_#{disp}"
    end
  end
end
