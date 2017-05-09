Rails.application.routes.draw do
  root 'users#new'
  post '/users' => 'users#create'
  get "/show" => 'users#show', as: 'show'
end
