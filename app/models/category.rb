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
  
  # Get all of the root level categories for a set of items. There has to be a better way to do this.
  # TODO: Refactor this so that it's less convoluted and uses less queries.
  def self.top_level_categories_for_items(items)
    if items.length > 0
      item_ids_string = items.map { |i| i.id }.join(',')
      parents = self.find(:all, :conditions => ["id IN (#{item_ids_string}) AND category_id IS ?", nil], :include => :categories)
      children = self.find(:all, :conditions => ["id IN (#{item_ids_string}) AND category_id NOT ?", nil], :include => :category)
      if children.length > 0
        for child in children
          parents << child.category unless parents.include?(child.category)
        end
      end
    end
    return parents || []
  end
end
