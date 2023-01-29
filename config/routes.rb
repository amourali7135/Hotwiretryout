Rails.application.routes.draw do
  root to: "pages#home"
  resources :restaurants do #, only: [ :index, :show, :new, :create, :update, :edit,  ] do
    resources :reviews, only: :create
  end
end
