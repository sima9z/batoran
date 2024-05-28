Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  post '/update_location', to: 'application#update_location'
  root to:"tops#top"
  get 'top', to: 'tops#top'  # /topへのルーティングを追加

  resources :signs, only: [:index, :show]
  resources :planets, only: [:index, :show]
  resources :fortunes, only: [:index, :show]

  # Defines the root path route ("/")
  # root "posts#index"
end
