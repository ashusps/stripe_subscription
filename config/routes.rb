Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :subscriptions, :only => [:show, :update, :create, :destroy]
      resources :plans, :except => [:destroy, :new]
      resources :users, :except => [:new]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
