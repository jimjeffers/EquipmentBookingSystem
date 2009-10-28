class Item < ActiveRecord::Base
  # Plugins
  acts_as_taggable
  has_attached_file :image, :styles => { :medium => "280x280", :thumb => "115x115" }
  has_guid :name
  
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
