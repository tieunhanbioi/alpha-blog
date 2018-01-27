ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  def sign_in_as(user,password)
    post "http://localhost:3000/login", params: { session: { email: user.email, password: password }}
  end
  # Add more helper methods to be used by all tests here...
end
