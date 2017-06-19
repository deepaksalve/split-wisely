Rails.application.routes.draw do
  # Routes for registration and session
  devise_for :users, controllers: { registrations: 'registrations' }

  # Root
  root to: 'application#home'

  # Public routes
  scope '/public' do
    get '/home', to: 'application#home', as: 'home'
    get '/about', to: 'application#about', as: 'about'
    get '/contact', to: 'application#contact', as: 'contact'
  end

  # Authorized routes
  resources :groups, only: [:index, :new, :create, :show]
end
