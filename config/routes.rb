OpiniodevRailsApp::Application.routes.draw do
  resources :users


  get "home/index"

  resources :ideas do
    get :search, :on => :collection
  end

  root :to => 'home#index'
end
