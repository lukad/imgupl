Rails.application.routes.draw do
  scope ENV.fetch('APP_ROOT_PREFIX', '') do
    root to: 'dummy#dummy'
  end
end
