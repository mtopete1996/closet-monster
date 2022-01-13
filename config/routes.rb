Rails.application.routes.draw do
  root to: 'welcome#show'

  devise_for :users

  # /admin
  namespace :admin do
    root to: 'dashboards#show'
    resources :cloth_brands, except: :show
    resources :cloth_types, except: :show
    resources :cloths, except: :show
    resource :calendar, only: :show, controller: :cloth_logs
  end

  # /monster
  namespace :monster do
    root to: 'dashboards#show'
    resources :cloth_brands, except: :show
    resources :cloth_types, except: :show
    resources :cloths, except: :show
    resource :calendar, only: :show, controller: :cloth_logs
  end
end
