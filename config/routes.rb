Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :restaurants do #, only: [ :index, :show, :new, :create, :update, :edit,  ] do
    resources :reviews, only: :create
  end
end
