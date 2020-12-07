Rails.application.routes.draw do
  root to: 'welcome#show'

  devise_for :users

  namespace :admin do
    root to: 'dashboards#show'
    resources :cloth_brands, except: :show
    resources :cloth_types, except: :show
    resources :cloths, except: :show
  end

  namespace :monster do
    root to: 'dashboards#show'
    resources :cloth_brands, except: :show
    resources :cloth_types, except: :show
    resources :cloths, except: :show
  end
end
