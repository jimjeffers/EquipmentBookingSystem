class AddIncludeListToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :included_items, :text
  end

  def self.down
    remove_column :items, :included_items
  end
end
