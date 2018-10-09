Rails.application.routes.draw do
  get 'home/top'
  get 'home/index'
  post 'home/create'
  get 'home/new'
  get 'home/show'
  get 'home/show/:id' => 'home#show'
  root 'application#hello'
end
