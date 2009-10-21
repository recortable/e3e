class SurveyViviendaExtraFields < ActiveRecord::Migration
  def self.up
    add_column :surveys, :vivienda_fachada, :string, :lenght => 8
    add_column :surveys, :vivienda_acristalado, :string, :lenght => 8
  end

  def self.down
    remove_column :surveys, :vivienda_fachada
    remove_column :surveys, :vivienda_acristalado
  end
end
