Rails.application.routes.draw do

  resources :advertisements

  resources :topics do
    resources :sponsored_posts
    resources :posts, except: [:index]
  end

  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
    post '/up-vote' => "votes#up_vote", as: :up_vote
    post '/down-vote' => "votes#down_vote", as: :down_vote #as down_vote to create down_vote_path helper
    resources :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  resources :labels, only: [:show]
  
  get 'about' => 'welcome#about'

  get 'welcome/contact'

  get 'welcome/faq'
  
  root to: 'welcome#index'
end
