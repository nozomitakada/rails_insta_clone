Rails.application.routes.draw do
  root to:"users#new"
  
  resources :pictures do
    collection do
      post :confirm
    end
  end
  resources :tops
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  
  
  resources :favorites, only: [:create, :destroy, :show]
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  
end