class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.references :category
      t.string :name
      t.integer :instances_count
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
