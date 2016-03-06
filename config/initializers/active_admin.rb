ActiveAdmin.setup do |config|
  config.site_title = 'Imgupl'
  config.default_namespace = :admin
  config.authentication_method = :authenticate_admin_user!
  config.current_user_method = :current_user
  config.logout_link_path = :destroy_user_session_path
  config.logout_link_method = :delete
  config.comments = false
  config.comments_registration_name = 'AdminComment'
  config.batch_actions = true
end
