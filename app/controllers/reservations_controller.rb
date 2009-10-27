class ReservationsController < ApplicationController
  layout 'main'
  before_filter :login_required
  
  # Displays a logged in user's reservations dashboard.
  def index
    
  end
end
