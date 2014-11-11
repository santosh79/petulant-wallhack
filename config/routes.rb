Rails.application.routes.draw do
  get 'mean/index'
  post 'mean/update'
  post 'mean/update/:number', to: 'mean#update', constraints: { id: /\d+/ }
  root 'mean#index'
end
