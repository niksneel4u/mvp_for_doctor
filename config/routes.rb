Rails.application.routes.draw do
  get 'doctors/index'
  get 'patients/index'
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  resources :patients
  resources :doctors
  resources :book_appointments, only: [:index]
  resources :appointments do
    get 'booking'
    get 'accept'
    get 'reject'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
end
