Rails.application.routes.draw do

  resources :advertisements

  resources :topics do
    resources :sponsored_posts
    resources :posts, except: [:index]
  end

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  resources :labels, only: [:show]
  
  get 'about' => 'welcome#about'

  get 'welcome/contact'

  get 'welcome/faq'
  
  root to: 'welcome#index'
end
