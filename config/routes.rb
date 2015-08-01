Rails.application.routes.draw do
  scope ENV.fetch('APP_ROOT_PREFIX', '') do
    root to: 'uploads#index'

    get :upload, to: 'uploads#new', as: 'new_upload'

    resources :uploads do
      resources :comments, only: [:create, :destroy]
    end

    devise_for :users
    ActiveAdmin.routes(self)
  end
end
