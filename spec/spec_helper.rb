# frozen_string_literal: true

require 'chefspec'
require 'chefspec/berkshelf'

require_relative '../libraries/chef_ca'

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
  config.log_level = :error
  config.expose_dsl_globally = true
  config.mock_with :rspec do |mocks|
    mocks.allow_message_expectations_on_nil = true
  end
end
