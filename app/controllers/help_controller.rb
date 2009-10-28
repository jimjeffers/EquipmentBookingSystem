class HelpController < ApplicationController
  layout 'main'
  
  # Displays the help and guides dashboard.
  def index
    @section = Section.first
  end
  
  # Displays a specific solution to a help question.
  def answer
  end
  
  # Temporary and can be removed once content becomes truly dynamic.
  def contact
  end
end
