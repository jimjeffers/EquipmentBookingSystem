class EquipmentController < ApplicationController
  layout 'main'
  
  # Displays homepage for the equipment booking system.
  def index
  end
  
  # Displays a category.
  def browse
    @page_class = 'search_results browse'
  end
  
  # Presents a search result view.
  def search
    @page_class = 'search_results'
  end
  
  # Displays an instance.
  def item
    respond_to do |format| 
      format.html 
      format.js { render :partial => 'cart_form' }
    end
  end
  
  # Adds submitted item to cart.
  def add_to_cart
    respond_to do |format| 
      format.html 
      format.text { render :partial => 'success' }
    end
  end
end
