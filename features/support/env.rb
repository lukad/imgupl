require 'simplecov'
SimpleCov.start 'rails' do
  add_filter 'app/admin'
end

require 'cucumber/rails'
require 'email_spec/cucumber'

ActionController::Base.allow_rescue = false

DatabaseCleaner.strategy = :transaction

Cucumber::Rails::Database.javascript_strategy = :truncation
