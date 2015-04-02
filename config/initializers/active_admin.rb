ActiveAdmin.setup do |config|
  config.site_title = 'Imgupl'
  config.site_title_link = ENV.fetch('APP_ROOT_PATH', '/')
  config.default_namespace = :admin
  config.authentication_method = :authenticate_admin_user!
  config.current_user_method = :current_user
  config.logout_link_path = :destroy_user_session_path
  config.logout_link_method = :delete
  config.comments = false
  config.batch_actions = true
end