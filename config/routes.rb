Twlatch::Application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'tweets', to: 'home#tweets'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'


  post 'pair', to: 'home#pair'
  post 'unpair', to: 'home#unpair'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show, :tweets]
  root to: "home#show"
end
