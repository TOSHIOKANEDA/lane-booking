Rails.application.routes.draw do

devise_for :users
  root 'orders#index'
  post "orders/confirm" =>  "orders#confirm"
  post "orders/done" =>  "orders#done"
  get 'orders/authority'  =>  'orders#authority'
  devise_scope :user do
  get 'users/:id/edit'  =>  'users/sessions#edit'
  patch 'users/:id/edit' => 'users/sessions#update'
  delete 'users/:id' => 'users/sessions#destroy'
  get 'users/:id'  =>  'users/sessions#destroy'
  end
end
