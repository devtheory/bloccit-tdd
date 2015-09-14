Rails.application.routes.draw do

  resources :advertisements

  resources :topics do
    resources :sponsored_posts
    resources :posts, except: [:index]
  end

  resources :users, only: [:new, :create]
  
  get 'about' => 'welcome#about'

  get 'welcome/contact'

  get 'welcome/faq'
  
  root to: 'welcome#index'
end
