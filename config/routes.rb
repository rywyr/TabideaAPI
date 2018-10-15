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

  post 'event/create/:user_id' => 'event#create'
  get 'event/index'
<<<<<<< HEAD
  get 'event/join/:user_id/:event_id' => 'event#join'
  get 'event/show/:user_id/:event_id' => 'event#show'
  get 'event/show/:user_id' => 'event#show'
=======
  get 'event/join/:user_id/:event_id' =>'event#join'
>>>>>>> bcb70893976d0d73dc3746b242f4835a4504f813

  get 'home/top'
  get 'home/index/:uuid' => 'home#index'
  post 'home/edit'
  post 'home/usercreate' => 'home#usercreate'
  delete 'home/destroy/:name' =>'home#destroy'

  root 'application#hello'
end
