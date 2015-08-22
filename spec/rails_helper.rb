ENV['RAILS_ENV'] ||= 'test'
if ENV.key? 'TRAVIS'
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
else
  require 'simplecov'
  SimpleCov.start 'rails' do
    add_filter 'app/admin'
  end
end

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

require 'shoulda/matchers'
require 'cancan/matchers'
require 'database_cleaner'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false

  config.include FactoryGirl::Syntax::Methods
  config.before(:suite) do
    begin
      DatabaseCleaner.start
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end

  config.infer_spec_type_from_file_location!

  config.include Devise::TestHelpers, type: :controller
  config.extend Login, type: :controller
end
