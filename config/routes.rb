ActionController::Routing::Routes.draw do |map|
  map.resources :clients, :member => {:subject_id_from_name => :get, :role_id_from_name => :get}#TODO: write functional test    
  map.resources :clients do |client|
    client.resources :subjects,
    :member => {
      :has_access => :get,    # the url should look like this  /clients/:client_id/subjects/:id/has_access  params[:resource]=(resoruce string described by REG EXP)
      :is_subject_in_role => :get,
      :add_role => :put,
      :remove_role => :put      
    }     
    client.resources :roles,
    :member => {
      :add_subject => :put,
      :remove_subject => :put,
      :add_resource => :put,
      :remove_resource => :put
    }
    client.resources :resources,
    :member => {
      :add_role => :put,
      :remove_role => :put      
    }     
    
  end

  map.resources :profiles

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "home"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
    map.home '/home/index', :controller => "home", :action => "index"
    map.insufficient '/home/insufficient', :controller => "home", :action => "insufficient"
    map.ourclients '/home/ourclients', :controller => "home", :action => "ourclients"
    map.help '/home/help', :controller => "home", :action => "help"
    map.faq '/home/faq', :controller => "home", :action => "faq"
    map.terms '/home/terms', :controller => "home", :action => "terms"
    map.login '/login', :controller => "subjects", :action => "login"  
end
