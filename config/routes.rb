Rails.application.routes.draw do
  root 'movie#index'
  post '/search', to: 'movie#search'
  get '/search', to: 'movie#search'
end
