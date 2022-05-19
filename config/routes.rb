Rails.application.routes.draw do
  namespace :recipes do
    resources :search, only: %i[index]
  end

  root "home#index"
end
