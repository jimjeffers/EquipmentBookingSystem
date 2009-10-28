class EquipmentController < ApplicationController
  layout 'main'
  
  # Displays homepage for the equipment booking system.
  def index
    @categories = Category.root_level
  end
  
  def checkout
    @items = cookies[:items]
  end
  
  # Displays a category.
  def browse
    @page_class = 'search_results browse'
    @category = Category.find_by_guid(params[:guid])
    @parent_category = @category.parents.last if @category.parents.length > 0
    @items = @category.items_and_nested_items
  end
  
  # Presents a search result view.
  def search
    @page_class = 'search_results'
    @items = Item.find_tagged_with(params[:search])
    @categories = Category.top_level_categories_for_items(@items)
  end
  
  # Displays an instance.
  def item
    @item = Item.find_by_guid(params[:guid])
    @alternative_items = @item.alternatives
    respond_to do |format|
      format.html
      format.text { render :partial => 'quick_cart.html' }
    end
  end
  
  # Adds submitted item to cart.
  def add_to_cart
    cookies[:items] = "" if cookies[:items].nil?
    @item = Item.find(params[:item_id])
    cookies[:items] = cookies[:items] + " " + @item.id.to_s
    
    respond_to do |format| 
      format.html 
      format.text { render :partial => 'success' }
    end
  end
end