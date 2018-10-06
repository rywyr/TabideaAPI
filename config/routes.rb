Rails.application.routes.draw do
  get 'home/top'
  get 'home/index'
  get 'home/edit'
  root 'application#hello'
end
