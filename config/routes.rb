App::Application.routes.draw do

  get "dashboard/show"
  devise_for :users
  resource :account, only: [:edit, :update]
  root :to => 'dashboard#show'
  
end
