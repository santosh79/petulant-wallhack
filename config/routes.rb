Rails.application.routes.draw do
  get 'mean/index'
  post 'mean/reset'
  post 'mean/update'
  root 'mean#index'
end
