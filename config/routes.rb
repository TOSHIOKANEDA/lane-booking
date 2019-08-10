Rails.application.routes.draw do

devise_for :users, controllers: {
  sessions: 'users/sessions'
}
  root 'orders#index'
  post "orders/confirm" =>  "orders#confirm"
  post "orders/done" =>  "orders#done"
end
