Rails.application.routes.draw do
  root to: 'welcome#show'

  devise_for :users

  namespace :admin do
    resource :dashboard, only: :show
    resources :cloths, except: :show
  end

  namespace :monster do
    resource :dashboard, only: :show
    resources :cloths, except: :show
  end
end
