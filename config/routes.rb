Rails.application.routes.draw do
  resources :users, only: :create

  resources :apps do
    resources :events, except: [:destroy, :update], controller: 'apps/events'
  end
end
