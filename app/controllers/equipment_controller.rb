class EquipmentController < ApplicationController
  layout 'main'
  
  # Displays homepage for the equipment booking system.
  def index
  end
  
  # Displays a category.
  def browse
  end
  
  # Presents a search result view.
  def search
    @page_class = 'search_results'
  end
  
  # Displays an instance.
  def item
  end
end
