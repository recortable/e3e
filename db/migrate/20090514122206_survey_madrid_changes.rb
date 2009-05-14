class SurveyMadridChanges < ActiveRecord::Migration
  def self.up
    remove_column :surveys, :edificio_anyo
  end

  def self.down
    add_column :surveys, :edificio_anyo, :string, :limit => 4
  end
end
