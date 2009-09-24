class CreateInstances < ActiveRecord::Migration
  def self.up
    create_table :instances do |t|
      t.references :item
      t.string :part_number
      t.string :aasm_state
      t.timestamps
    end
  end

  def self.down
    drop_table :instances
  end
end
