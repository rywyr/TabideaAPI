Rails.application.routes.draw do
  get 'home/top'
  get 'home/index'
  post 'home/edit'
  post 'home/create'
  post 'home/jcre'
  delete 'home/destroy/:name' =>'home#destroy'
  get 'home/destroy'
  get 'home/new'
  get 'home/show'
  get 'home/show/:id' => 'home#show'
  root 'application#hello'
end
