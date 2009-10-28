class Category < ActiveRecord::Base
  # Plugins
  has_guid :name
  
  # Relationships
  has_many :categories
  has_many :items
  belongs_to :category
  
  # Validations
  validates_presence_of :name
  validates_uniqueness_of :name
  
  # Scopes
  default_scope :order => 'position ASC, created_at DESC'
  named_scope :root_level, :conditions => ['category_id IS ?',nil], :include => {:categories => :categories}
  
  # Returns parent categories of the current instance in an array.
  def parents
    parents = []
    current = category_id
    while current
      parents << (parent = Category.find(current))
      current = parent.category_id
    end
    return parents.reverse!
  end
  
  # Returns item count including counts the current instances immediate children.
  def item_count
    count = items.count
    categories(:include => :items).each do |child|
      count += child.items.count
    end
    return count
  end
  
  # Returns all items in the current category and it's children's items.
  def items_and_nested_items
    Item.all_in_given_categories([self]+categories)
  end
end
