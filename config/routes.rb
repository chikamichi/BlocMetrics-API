Rails.application.routes.draw do
    resources :users, only: :create

    resources :applications, only: [:show, :create, :update, :destroy]
end
