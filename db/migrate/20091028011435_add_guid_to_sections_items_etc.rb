class AddGuidToSectionsItemsEtc < ActiveRecord::Migration
  def self.up
    add_column :items, :guid, :string
    add_column :questions, :guid, :string
    add_column :sections, :guid, :string
    add_column :categories, :guid, :string
  end

  def self.down
    remove_column :categories, :guid
    remove_column :sections, :guid
    remove_column :questions, :guid
    remove_column :items, :guid
  end
end
