Rails.application.routes.draw do
    resources :users, only: :create

    resources :apps, only: [:show, :create, :update, :destroy]
end
