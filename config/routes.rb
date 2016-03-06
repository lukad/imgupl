Rails.application.routes.draw do
  root to: 'uploads#index'

  get :upload, to: 'uploads#new', as: 'new_upload'

  resources :uploads do
    resources :comments, only: [:create, :destroy]
  end

  devise_for :users

  begin
    ActiveAdmin.routes(self)
  rescue ActiveAdmin::DatabaseHitDuringLoad => e
    Rails.logger.error("ActiveAdmin: #{e.class}: #{e}")
  end
end
