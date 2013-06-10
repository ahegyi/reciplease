Reciplease::Application.routes.draw do
  get "recipes/index"

  get "recipes/show"

  get "recipes/edit"

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end