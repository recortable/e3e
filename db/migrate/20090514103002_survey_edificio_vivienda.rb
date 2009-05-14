class SurveyEdificioVivienda < ActiveRecord::Migration
  def self.up

    add_column :surveys, :provincia_id, :integer
    add_column :surveys, :municipio_id, :integer

    add_column :surveys, :edificio_anyo, :string, :limit => 4
    add_column :surveys, :edificio_periodo, :string, :limit => 32

    add_column :surveys, :vivienda_tipo_edificio, :string, :limit => 32
    add_column :surveys, :vivienda_num_plantas, :integer
    add_column :surveys, :vivienda_planta, :string
    add_column :surveys, :vivienda_estancias, :integer
    add_column :surveys, :vivienda_servicios, :integer
    add_column :surveys, :vivienda_tejado, :string
    add_column :surveys, :vivienda_superficie, :float

    Survey::VIVIENDA_REFORMAS.each do |reforma|
      add_column :surveys, "vivienda_#{reforma}", :boolean
    end

    add_column :surveys, :vivienda_reforma_ultima, :string, :limit => 32

  end

  def self.down
    remove_column :surveys, :provincia_id
    remove_column :surveys, :municipio_id

    remove_column :surveys, :edificio_anyo, :string
    remove_column :surveys, :edificio_periodo, :string

    remove_column :surveys, :vivienda_tipo_edificio
    remove_column :surveys, :vivienda_num_plantas
    remove_column :surveys, :vivienda_planta
    remove_column :surveys, :vivienda_estancias
    remove_column :surveys, :vivienda_servicios
    remove_column :surveys, :vivienda_tejado
    remove_column :surveys, :vivienda_superficie

    Survey::VIVIENDA_REFORMAS.each do |reforma|
      remove_column :surveys, "vivienda_#{reforma}"
    end
    remove_column :surveys, :vivienda_reforma_ultima

  end
end
