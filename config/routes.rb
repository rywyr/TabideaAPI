Rails.application.routes.draw do
  apipie
  get 'rooms/show'
  mount ActionCable.server => '/cable'
 
  post 'event/create/:user_id' => 'event#create'
  get 'event/index'
  get 'event/join/:user_id/:event_id' => 'event#join'
  get 'event/show/:user_id/:event_id' => 'event#show'
  get 'event/show/:user_id' => 'event#show'

  get 'home/top'
  get 'home/index/:uuid' => 'home#index'
  get 'home/show/:uuid' => 'home#show'
  get 'home/allusers'
  post 'home/edit/:id' => 'home#edit'
  post 'home/usercreate' => 'home#usercreate'
  delete 'home/destroy/:name' =>'home#destroy'

  root 'application#hello'
end
