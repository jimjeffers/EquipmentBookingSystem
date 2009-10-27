class Category < ActiveRecord::Base
  # Relationships
  has_many :categories
  belongs_to :category
  
  # Validations
  validates_presence_of :name
  validates_uniqueness_of :name
  
  # Scopes
  default_scope :order => 'position ASC, created_at DESC'
end
