Rails.application.routes.draw do

  get 'welcome/about'

  get 'welcome/contact'
  
  root to: 'welcome#index'
end
