Rails.application.routes.draw do
  get 'home/top'
  get 'home/index'
  post 'home/create'
  get 'home/new'
  root 'application#hello'
end
