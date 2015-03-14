Rails.application.routes.draw do
  scope ENV.fetch('APP_ROOT_PREFIX', '') do
    root to: 'dummy#dummy'

    devise_for :users
  end
end
