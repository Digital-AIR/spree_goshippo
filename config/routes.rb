Spree::Core::Engine.add_routes do
  # Add your extension routes here
   namespace :admin do
  	resources :goshippos, only: [:index]
  end
end
