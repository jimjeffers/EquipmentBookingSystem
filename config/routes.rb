ActionController::Routing::Routes.draw do |map|
  # Resources
  map.resources :questions
  map.resources :sections
  map.resources :categories
  map.resources :bookings
  map.resources :instances
  map.resources :items
  
  # Sorting paths.
  map.categories_update_order '/categories/update_order', :controller => 'categories', :action => 'update_order'
  map.sections_update_order '/sections/update_order', :controller => 'sections', :action => 'update_order'
  map.items_update_order '/items/update_order', :controller => 'items', :action => 'update_order'
  map.questions_update_order '/questions/update_order', :controller => 'questions', :action => 'update_order'
  
  # Custom front end paths.
  map.item_detail '/item/:guid', :controller => 'help', :action => 'section'
  map.category_browse '/browse/:guid', :controller => 'equipment', :action => 'browse'
  map.help_section '/help/:guid', :controller => 'help', :action => 'section'
  
  
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
