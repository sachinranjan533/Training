Rails.application.routes.draw do
  devise_for :users
  get "home",to: "pages#home"
  root "welcome#index"
  resources :posts
  resources :comments
  get "recovery",to: "posts#recovery"
end
