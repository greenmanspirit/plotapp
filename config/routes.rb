PlotApp::Application.routes.draw do
  resources :forums do 
	resources :topics, :shallow => true do
		resources :posts, :shallow => true
	end
  end

  resources :messages

  get "messages/new/:recipient_id", :to => "messages#new", :as => "send_new_message"

  devise_for :authors, :controllers => { :registrations => "registrations" } do
  	get "profile/:id", :to => "authors#profile", :as => "view_author_profile"
	get "profile/fan/:id", :to => "authors#fan", :as => "fan_author"
	get "profile/defan/:id", :to => "authors#defan", :as => "defan_author"
	get "authors", :to => "authors#index", :as => "authors"
  end

  resources :authors

  resources :stories do
  	resources :plotpoints, :shallow => true do 
		collection do
			post 'sort'
		end
	end
	resources :characters, :shallow => true
	resources :settings, :shallow => true do
		resources :features
	end
	get "fan", :to => "stories#fan", :as => "fan"
	get "defan", :to => "stories#defan", :as => "defan"
  end

  get "home/index"
  

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "home#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
