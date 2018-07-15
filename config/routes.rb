Rails.application.routes.draw do
  #Actor routes
  get 'person/show'
  get 'person/index'

  #Search routes
  post 'search/index'
  get 'search/index'

  #Movie routes
  get 'movie/index'
  get 'movie/show'

  #TV routes
  get 'tv/index'
  get 'tv/show'

  #Welcome routes
  get 'welcome/index'
  get 'welcome/about'
  get 'welcome/contact'

  #Root route
  root 'welcome#index'
end
