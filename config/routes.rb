Rails.application.routes.draw do
  devise_for :users
  get "home",to: "pages#home"
  get "users",to: "paths#index"
  root "welcome#index"
  resources :posts
  resources :comments
  get "recovery",to: "posts#recovery"
end
