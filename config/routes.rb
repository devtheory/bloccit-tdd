Rails.application.routes.draw do

  resources :posts
  
  get 'about' => 'welcome#about'

  get 'welcome/contact'

  get 'welcome/faq'
  
  root to: 'welcome#index'
end
