Rails.application.routes.draw do
  resources :readings, only: [:index, :show, :create]
end
