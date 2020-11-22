Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resource :dashboard, only: :show
  end

  namespace :monster do
    resource :dashboard, only: :show
    resources :cloths
  end
end
