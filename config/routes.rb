Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      post 'authenticate', to: 'authentication#create'
      resources :users, only: %i[create]
      resources :articles, only: %i[index create show] do
        delete '/likes' => 'likes#destroy'
        post '/likes' => 'likes#create'
        get '/likes' => 'likes#index'
      end
    end
  end
end
