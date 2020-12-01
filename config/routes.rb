Rails.application.routes.draw do
  root to: 'welcome#show'

  devise_for :users

  namespace :admin do
    root to: 'dashboards#show'
    resources :cloths, except: :show
    resources :cloth_types, except: :show
  end

  namespace :monster do
    root to: 'dashboards#show'
    resources :cloths, except: :show
    resources :cloth_types, except: :show
  end
end
