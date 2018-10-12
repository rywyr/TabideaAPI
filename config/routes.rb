Rails.application.routes.draw do
  get 'mmocontroller/top'
  get 'mmocontroller/index'
  post 'mmocontroller/create'
  get 'mmocontroller/show'
  get 'mmocontroller/show/:id'=>'mmocontroller#show'
  get 'mmocontroller/eventshow/:id'=>'mmocontroller#eventshow'
  post 'mmocontroller/jcre'
  delete 'mmocontroller/destroy/:id'=>'mmocontroller#destroy'
  post 'mmocontroller/edit'
  post 'event/create/:id' => 'event#create'
  get 'event/index'
  get 'home/top'
  get 'home/index'
  get 'home/index/:uuid' => 'home#index'
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
