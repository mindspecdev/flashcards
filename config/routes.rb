Rails.application.routes.draw do

  root to: 'home#index'

  resources :cards

  resource :review, only: [:edit, :update]

end
