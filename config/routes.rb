OpiniodevRailsApp::Application.routes.draw do
  match '/auth/:provider/callback' => 'sessions#create', :via => [:post,:get]
  match "/signout" => "sessions#destroy", :as => :signout, :via => :get

  get "home/index"
  resources :users
  resources :ideas do
    get :search, :on => :collection
    get :total_ideas, :on => :collection
  end

  root :to => 'home#index'
end
