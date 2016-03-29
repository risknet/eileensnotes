Eileensnotes::Application.routes.draw do
  
  root  "welcome#index"
  get "welcome/index"

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  #authenticated :user do
  # root :to => "notes#index"
  #end
  #root :to => redirect("/users/sign_in")
  
  get "help/index"
  get "errors/index"
  get "markdown/index"
  get "clouds/index"
  
  # named routes
  # format is just like this
  # match 'notes/:note_id/comments/:id' => 'comments#destory', :as => :deletecomment
  
  # upgrade note: changed all match to get in this block
  # on 11/10/13, Jae Lee
  # NO Match with no HTTP is supported, use on of these
  # get '/patients/:id', to: 'patients#show', as: 'patient'
  # match 'new', to: 'episodes#new', via: [:get, :post]
  # match 'reviews/mark/:id', to: 'reviews#mark_to_review', as: 'marktoreview', via: [:get, :post]
  # match 'reviews/unmark/:id', to: 'reviews#unmark_review', as: 'unmarkreview', via: [:get, :post]
 
  get 'about', to: 'about#index', as: 'about'
  get 'reviews/mark/:id', to: 'reviews#mark_to_review', as: 'marktoreview'
  get 'reviews/unmark/:id', to: 'reviews#unmark_review', as: 'unmarkreview'
  get 'notes/usernotes/:id', to: 'notes#get_user_notes', as: 'get_user_notes'
  get 'taggednotes/:tag', to: 'notes#get_tagged_notes', as: 'get_tagged_notes'
  get 'taggedads/:tag', to: 'ads#get_tagged_ads', as: 'get_tagged_ads'
  get 'unanswered', to: 'notes#get_unanswered_notes', as: 'get_unanswered_notes'
  get 'reviews', to: 'reviews#index', as: 'reviews_by_user'
  # end of upgrade 
  
  devise_for :users
  
  # routes based on resource
  resources :notes do
    resources :answers,      :except => [:show]
  end
  resources :ads
  
  # gracefully handle any badly formed requests
  match '*anything', to: 'errors#index', via: [:get, :post]
  
  #resources :reviews

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
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
