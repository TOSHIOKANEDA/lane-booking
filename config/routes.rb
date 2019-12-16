Rails.application.routes.draw do

devise_for :users
  root 'orders#index'
  resources :orders, :only => [:update, :destroy, :edit, :new]
  get 'orders/list' => 'orders#list'
  post "orders/confirm" =>  "orders#confirm"
  post "orders/done" =>  "orders#done"
  get 'orders/authority'  =>  'orders#authority'
  devise_scope :user do
  get 'users/:id/edit'  =>  'users/sessions#edit'
  patch 'users/:id/edit' => 'users/sessions#update'
  delete 'users/:id' => 'users/sessions#destroy'
  get 'users/:id'  =>  'users/sessions#destroy'
  end
  
  get    'users/:id/show'   =>  'users#show'
  
end
