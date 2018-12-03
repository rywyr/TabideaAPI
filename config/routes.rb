Rails.application.routes.draw do
  get 'category/show'
  get 'category/create'
  get 'category/destroy'
  apipie
  get 'rooms/show'
  mount ActionCable.server => '/cable'
 
  post    'event/create/:user_id' => 'event#create'
  get     'event/index'
  get     'event/show/:user_id/:event_id' => 'event#show'
  get     'event/show/:user_id' => 'event#show'
  delete  'event/destroy/:event_id' => 'event#destroy'
  get     'event/search/:password' => 'event#search'
  get     'event/invitation/:user_id/:event_id' => 'event#invitation'
  get     'event/withdrawal/:user_id/:event_id' => 'event#withdrawal'

  #get     'event/:eventtoken' => 'event#auth'
  get     'event/join/:user_id/:eventtoken' => 'event#join'

  get     'home/show/:uuid' => 'home#show'
  get     'home/allusers'
  post    'home/edit/:id' => 'home#edit'
  post    'home/usercreate' => 'home#usercreate'
  post    'home/upload/:id' => 'home#upload'
  delete  'home/destroy/:id' =>'home#destroy'


  get     'categories/:event_id'  => 'category#show'
  post    'categories/:event_id' => 'category#create'    
  delete  'categories/:category_id' => 'category#destroy'

  root 'application#hello'
end
