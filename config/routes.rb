Rails.application.routes.draw do

devise_for :users, controllers: {
  sessions: 'users/sessions'}
  root 'orders#index'
  post "orders/confirm" =>  "orders#confirm"
  post "orders/done" =>  "orders#done"
  get 'orders/authority'  =>  'orders#authority'
  get 'users/:id/edit'  =>  'users/sessions#edit'
  patch 'users/:id/edit' => 'users/sessions#update'
  delete 'users/:id' => 'users/sessions#destroy', as: 'destroy_session_user'
end
