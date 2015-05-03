require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Imgupl
  class Application < Rails::Application
    config.time_zone = 'Berlin'
    config.i18n.default_locale = :en

    # Asset config
    config.assets.prefix = File.join(ENV.fetch('APP_ROOT_PREFIX', ''), 'assets')

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.to_prepare do
      Devise::Mailer.layout 'mailer'
    end
  end
end
