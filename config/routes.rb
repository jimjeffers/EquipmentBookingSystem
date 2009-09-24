ActionController::Routing::Routes.draw do |map|  
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
end
