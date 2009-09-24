class Category < ActiveRecord::Base
  # Relationships
  has_many :categories
  belongs_to :category
end
