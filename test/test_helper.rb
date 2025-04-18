ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
# Run tests in parallel with specified workers
parallelize(workers: :number_of_processors)

# Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
include Devise::Test::IntegrationHelpers
end

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    # Helper method to simulate login
    def login_as(user)
      # Create a session for the user
      session = user.sessions.create!(
        user_agent: "Rails Testing",
        ip_address: "127.0.0.1"
      )

      # Set the session cookie
      cookies[:session_id] = {
        value: session.id,
        httponly: true,
        same_site: :lax
      }
    end
  end
end
