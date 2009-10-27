class Item < ActiveRecord::Base
  # Relationships
  has_many :instances
  belongs_to :category
  
  # Validations
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :category_id
  
  # Scopes
  default_scope :order => 'position ASC, created_at DESC'
end
