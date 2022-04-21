Rails.application.routes.draw do
  resources :follows

  devise_for :users, controllers: { registrations: 'registrations' }

  post '/users/:id/follow', to: "users#follow", as: "follow_user"
  post '/users/:id/unfollow', to: "users#unfollow", as: "unfollow_user"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'posts#index'

  resources :users, only: [:show]

  resources :posts do
    resources :photos, only: [:create]
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]

    member do
      put 'like' => 'posts#like'
    end
  end
end
