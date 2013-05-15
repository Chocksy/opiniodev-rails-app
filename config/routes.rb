OpiniodevRailsApp::Application.routes.draw do
  match '/auth/:provider/callback' => 'sessions#create', :via => [:post, :get]
  match "/signout" => "sessions#destroy", :as => :signout, :via => :get
  match "/ideas/upvote/:id" => "ideas#upvote", :as => :upvote, :via => :put
  match "/ideas/downvote/:id" => "ideas#downvote", :as => :downvote, :via => :put

  get "home/index"
  resources :users
  resources :ideas

  root :to => 'home#index'
end
