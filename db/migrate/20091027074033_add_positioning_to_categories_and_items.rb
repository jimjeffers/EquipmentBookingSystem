class AddPositioningToCategoriesAndItems < ActiveRecord::Migration
  def self.up
    add_column :items, :position, :integer, :default => 0
    add_column :categories, :position, :integer, :default => 0
  end

  def self.down
    remove_column :categories, :position
    remove_column :items, :position
  end
end
