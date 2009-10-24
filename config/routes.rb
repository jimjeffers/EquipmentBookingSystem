ActionController::Routing::Routes.draw do |map|
  map.resources :categories
  map.resources :bookings
  map.resources :instances
  map.resources :items
  
  # Authentication routing.
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  
  map.resources :users do |user|
    user.resources :booking
  end
  
  map.resource :session
  
  map.resources :categories do |category|
    category.resources :items do |item|
      item.resources :instances
    end
  end

  # Default routing.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.conntect '/', :controller => 'equipment'
end
