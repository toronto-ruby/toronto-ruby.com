Rails.application.routes.draw do
  resources :events, only: [:index, :show] do
    collection do
      get 'past', to: 'events#past'
      get 'all', to: 'events#all', as: :all
      get 'next', to: 'events#next'
    end
  end

  namespace :admin do
    resources :events, except: %i[show]
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  #
  root 'events#index'
  get 'past-events', to: redirect('/events/past')
  get 'past_events', to: redirect('/events/past')
  get 'chat', to: 'static#chat'
  get 'about', to: 'static#about'
  get 'calendar', to: 'static#calendar'
end
