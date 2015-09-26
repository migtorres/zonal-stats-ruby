require 'bundler/setup'
Bundler.setup

require 'zonal-stats' # and any other gems you need
require 'rspec/mocks'

RSpec.configure do |config|
  config.mock_with :rspec
end