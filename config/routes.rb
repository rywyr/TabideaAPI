Rails.application.routes.draw do
  get 'home/top'
  root 'application#hello'
end
