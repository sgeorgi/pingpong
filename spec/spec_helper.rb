require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  ENV['RAILS_ENV'] ||= 'test'
  require 'simplecov'

  SimpleCov.start 'rails'

  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'factory_girl'
  require 'capybara/rails'
  require 'capybara/rspec'
  require 'forgery'
  require 'shoulda-matchers'

  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

  # Checks for pending migrations before tests are run.
  # If you are not using ActiveRecord, you can remove this line.
  # ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

  RSpec.configure do |config|
    config.include Capybara::DSL
    config.include FactoryGirl::Syntax::Methods

    config.include Devise::TestHelpers, type: :controller
    config.include Devise::TestHelpers, type: :view

    config.include ControllerTestHelper, type: :controller
    config.include FeatureTestHelper, type: :feature

    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.use_transactional_fixtures = false
    config.order = 'random'

    config.before(:suite) do
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
      DatabaseCleaner.strategy = :transaction
    end

    config.before(:each, :js => true) do
      DatabaseCleaner.strategy = :truncation
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

    config.before(type: :feature, with_devise_user: true) do
      email = 'test@test.com'
      password = 'ABC123xyz!!'
      create :user, :confirmed, email: email, password: password
    end
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.

end