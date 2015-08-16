Rails.application.routes.draw do
  scope ENV.fetch('APP_ROOT_PREFIX', '') do
    root to: 'uploads#index'

    get :upload, to: 'uploads#new', as: 'new_upload'

    concern :votable do
      member do
        post :upvote
        post :downvote
        delete :unvote
      end
    end

    resources :comments, only: [:destroy], concerns: [:votable]

    resources :uploads do
      resources :comments, only: [:create]
    end

    devise_for :users
    ActiveAdmin.routes(self)
  end
end
