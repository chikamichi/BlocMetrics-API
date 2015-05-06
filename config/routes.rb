Rails.application.routes.draw do
  resources :users, only: :create

  resources :apps do
    resources :events, except: [:destroy, :update, :create],
                       controller: 'apps/events'
  end
  # match '/apps', to: 'apps#options', via: [:options]

  resources :events, only: [:create]
end
