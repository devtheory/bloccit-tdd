Rails.application.routes.draw do

  get 'welcome/about'

  get 'welcome/contact'

  get 'welcome/faq'
  
  root to: 'welcome#index'
end
