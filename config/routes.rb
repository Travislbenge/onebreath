Rails.application.routes.draw do
  devise_for :users,
  controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  get 'pages/ui', to: 'pages#ui'
  get 'pages/dash', to: 'pages#dash', as: 'dash'
  get 'pages/info', to: 'pages#info', as: 'info'
  resources :presets do
    resources :activities
    resources :timer_sessions, only: [:create]
  end
  resources :breaks, only: [:index, :show, :update]
  resources :timer_sessions, only: [:index, :show, :destroy] do
    resources :breaks, only: [:new, :create, :show]
  end
  get 'timer_sessions/:id/stats', to: 'timer_sessions#stats', as: 'stats'
  resources :start_timer_sessions, only: [:update]
  resources :end_timer_sessions, only: [:update]
  resources :break_timer, only: [:update]
  resources :activities, only: [:destroy]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
