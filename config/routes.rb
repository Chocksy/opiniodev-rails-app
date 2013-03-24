OpiniodevRailsApp::Application.routes.draw do
  get "home/index"

  resources :ideas

  root :to => 'home#index'
end
