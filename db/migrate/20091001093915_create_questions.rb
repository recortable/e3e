class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.string :name
      t.string :human_name
      t.string :description
      t.string :properties
      t.string :group

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
