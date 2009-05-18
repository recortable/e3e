class SurveyMadridChanges < ActiveRecord::Migration
  def self.up
    remove_column :surveys, :edificio_anyo
    rename_column :surveys, :vivienda_tejado, :edificio_tejado
#    add_column :surveys, :equip_ilum_tiene_leds, :integer
  end

  def self.down
    add_column :surveys, :edificio_anyo, :string, :limit => 4
    rename_column :surveys, :edificio_tejado, :vivienda_tejado
#    remove_column :surveys, :equip_ilum_tiene_leds
  end
end
