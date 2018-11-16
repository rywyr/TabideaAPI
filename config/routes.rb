Rails.application.routes.draw do
  apipie
  get 'rooms/show'
  mount ActionCable.server => '/cable'
 
  post    'event/create/:user_id' => 'event#create'
  get     'event/index'
  post    'event/join/:user_id/:event_id' => 'event#join'
  get     'event/show/:user_id/:event_id' => 'event#show'
  get     'event/show/:user_id' => 'event#show'
  delete  'event/destroy/:event_id' => 'event#destroy'
  get     'event/search/:password' => 'event#search'
  get     'event/invitation/:user_id/:event_id' => 'event#invitation'
  get     'event/withdrawal/:user_id/:event_id' => 'event#withdrawal'

<<<<<<< HEAD
  get     'event/:token/:uuid' => 'event#join'
=======
  get     'event/:token/:user_id' => 'event#join'
>>>>>>> f200dc628d23cca376c86239c8950706b195197c

  get     'home/top'
  get     'home/index/:uuid' => 'home#index'
  get     'home/show/:uuid' => 'home#show'
  get     'home/allusers'
  post    'home/edit/:id' => 'home#edit'
  post    'home/usercreate' => 'home#usercreate'
  delete  'home/destroy/:id' =>'home#destroy'

  root 'application#hello'
end
