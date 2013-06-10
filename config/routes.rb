Reciplease::Application.routes.draw do

  authenticated :user do
    root :to => 'home#index'

    # RECIPES
    # => new, edit, create, update, destroy only accessible to authenticated users
    post "/recipes", :to => "recipes#create"

    get "/recipes/new", :to => "recipes#new", :as => "new_recipe"
    get "/recipes/:id/edit", :to => "recipes#edit", :as => "edit_recipe"

    put "/recipes/:id", :to => "recipes#update"
    delete "/recipes/:id", :to => "recipes#destroy"
  end

  # RECIPES
  # => index and show available to everyone
  get "/recipes", :to => "recipes#index", :as => "recipes"
  get "/recipes/:id", :to => "recipes#show", :as => "recipe"

  root :to => "home#index"

  devise_for :users
  resources :users
end