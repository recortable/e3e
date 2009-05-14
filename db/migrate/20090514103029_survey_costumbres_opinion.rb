class SurveyCostumbresOpinion < ActiveRecord::Migration
  def self.up
    add_column :surveys, :costumbres_personas, :integer
    add_column :surveys, :costumbres_horas, :integer
    add_column :surveys, :opinion, :text
  end

  def self.down
    remove_column :surveys, :costumbres_personas
    remove_column :surveys, :costumbres_horas
    remove_column :surveys, :opinion
  end
end
