Rails.application.routes.draw do

  get 'sponsored_posts/show'

  get 'sponsored_posts/new'

  get 'sponsored_posts/edit'

  resources :advertisements

  resources :topics do
    resources :sponsored_posts
    resources :posts, except: [:index]
  end
  
  get 'about' => 'welcome#about'

  get 'welcome/contact'

  get 'welcome/faq'
  
  root to: 'welcome#index'
end
