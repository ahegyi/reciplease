require 'resque/server'

Reciplease::Application.routes.draw do
  # see config.ru for authentication setup
  mount Resque::Server.new, :at => "/resque"

  authenticated :user do
    root :to => 'recipes#index'

    # RECIPES
    # => only accessible to authenticated users
    get "/recipes", :to => "recipes#index", :as => "recipes"
    post "/recipes", :to => "recipes#create"

    get "/recipes/new", :to => "recipes#new", :as => "new_recipe"

    get "/recipes/:id/edit", :to => "recipes#edit", :as => "edit_recipe"

    get "/recipes/:id", :to => "recipes#show", :as => "recipe"
    put "/recipes/:id", :to => "recipes#update"
    delete "/recipes/:id", :to => "recipes#destroy"
  end

  root :to => "home#index"

  devise_for :users
  resources :users
end