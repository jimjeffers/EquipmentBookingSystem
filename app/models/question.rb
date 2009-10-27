class Question < ActiveRecord::Base
  # Relationship
  belongs_to :section
  
  # Validations
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :section_id
  
  # Scopes
  default_scope :order => 'position ASC, created_at DESC'
end
