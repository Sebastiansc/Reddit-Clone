Rails.application.routes.draw do
  root to: 'subs#index'
  resources :users, only: [:create, :new, :show]
  resource :session, only: [:new, :create, :destroy, :show]

  resources :subs
  resources :posts do
    resources :comments, only: [:new]
  end

  resources :comments, only: [:destroy, :create, :edit, :update, :show] do
    resources :comments, only: [:new]
  end
end
