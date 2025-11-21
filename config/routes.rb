Rails.application.routes.draw do
  resources :lists, only: [:create, :index, :show] do
    resources :bookmarks, only: [:create, :new]
    end
  resources :bookmarks, only: :destroy
  root "lists#index"
end
