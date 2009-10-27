class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.string :name
      t.text :answer
      t.references :section
      t.integer :position, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
