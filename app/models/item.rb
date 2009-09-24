class Item < ActiveRecord::Base
  # Relationships
  has_many :instances
  belongs_to :category
end
