Rails.application.routes.draw do
  resources :users, only: :create

  resources :apps do
    resources :events, except: [:destroy, :update, :create],
                       controller: 'apps/events'
  end
  resources :events, only: [:create]
end
