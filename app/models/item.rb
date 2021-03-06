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
  named_scope :all_in_given_categories, lambda  { |categories| { :conditions => "category_id IN (#{categories.map { |c| c.id}.join(',')})" } }
  
  # Returns up to 5 other items in similar categories
  def alternatives
    if category.category
      return category.category.items_and_nested_items()
    else
      return category.items_and_nested_items()
    end
  end
  
  # Returns an array of the included items for a given item.
  def included_items_list
    included_items.split(',') unless included_items.nil?
  end
  
  # Item parent category tags.
  def parent_category_tags
    ([category]+category.parents).map { |c| "category_#{c.id}" }.join(" ")
  end
  
  # Searches items by category id or search term.
  def self.search(term,category_id)
    if !term.blank?
      if category_id.blank?
        return self.find_tagged_with(term+"%")
      else
        return self.find_tagged_with(term+"%", :conditions => ["category_id=?",category_id])
      end
    elsif !category_id.blank?
      return self.find_all_by_category_id(category_id)
    else
      return self.all
    end
  end
end