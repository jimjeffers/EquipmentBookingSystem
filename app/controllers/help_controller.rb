class HelpController < ApplicationController
  layout 'main'
  
  # Displays the help and guides dashboard.
  def index
    @section = Section.first
  end
  
  # Displays a specific solution to a help question.
  def section
    @section = Section.find_by_guid(params[:guid])
    render :action => 'index'
  end
  
  # Temporary and can be removed once content becomes truly dynamic.
  def contact
    @section = Section.new
  end
end
