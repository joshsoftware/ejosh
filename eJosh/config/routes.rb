ActionController::Routing::Routes.draw do |map|
  map.calendar '/calendar/:year/:month', :controller => 'calendar', :action => 'index', :year => Time.zone.now.year, :month => Time.zone.now.month
  map.resources :users, :member => {:activate => :get}
  map.resource :session
  map.resources :plugins

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
   map.root :controller => "home", :action => 'general', :page => 'Home'
   map.connect '/admin', :controller => 'admin/home'
   map.connect '/attachments/manage', :controller => 'attachments', :action => 'manage'
   map.connect '/attachments/create', :controller => 'attachments', :action => 'create'
   map.resources :site_under_construction

  # See how all your routes lay out with "rake routes"
    map.namespace :admin do |route|
      route.resources :home
      route.resources :pages, :collection => {:add => :post, :add_section => :post, :move => :get, :delete_psc => :get, :search => :any }
      route.resources :page_sections, :collection => {:search => :any, :preview => :any }
      route.resources :sites, :collection => [:go_live]
      route.resources :custom_layouts, :collection => {:apply => :post}
      route.resources :navigations , :member => {:enable => :get, :move => :get, :apply => :post}
      route.resources :extensions, :member => {:install => :get, :update_plugin => :get}
      route.resources :categories , :member => {:enable => :get}
      route.resources :crawlers, :member => {:enable => :get}
    end

   map.tag ':page/tag/:tag', :controller => 'home', :action => 'general'
   map.sub_general ':page/:category', :controller => 'home', :action => 'general'
   map.general ':page/', :controller => 'home', :action => 'general'
  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
