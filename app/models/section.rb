class Section < ActiveRecord::Base
  # Plugin
  has_guid :name
  
  # Relationships
  has_many :questions
  
  # Validations
  validates_presence_of :name
  validates_uniqueness_of :name
  
  # Scopes
  default_scope :order => 'position ASC, created_at DESC'
  
end
