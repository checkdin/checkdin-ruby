require 'rubygems'
require 'simplecov'
SimpleCov.start do
  add_filter "/spec"
end
require 'checkdin'
require 'rspec'

require 'webmock/rspec'
require 'vcr'

Dir["./spec/support/**/*.rb"].each {|f| require f}

# Disallow all HTTP connections
WebMock.disable_net_connect!

# VCR is used for recording and replaying known API HTTP interactions
VCR.config do |config|
  config.cassette_library_dir = File.join('spec', 'fixtures', 'vcr_cassettes')

  config.stub_with :webmock

  config.filter_sensitive_data('{client_id}')     { TestCredentials.client_id }
  config.filter_sensitive_data('{client_secret}') { TestCredentials.client_secret }
  config.filter_sensitive_data('{api_url}')       { TestCredentials.api_url }

  config.default_cassette_options = {
    :match_requests_on => [ :path ] # ignore hostname when finding a matching request in the VCR recording
  }
end

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros

  # from https://github.com/myronmarston/vcr/issues/95
  config.around(:each, :vcr => proc { |vcr, metadata| !!vcr }) do |example|
    options = example.metadata[:vcr]
    case options
    when String
      options = { :cassette => options }
    when TrueClass
      options = {}
    end
    name = options.delete(:cassette) || example.metadata[:full_description].split(/\s+/, 2).join("/").underscore.gsub(/[^\w\/]+/, "_")
    VCR.use_cassette(name, options) { example.call }
  end
end

DEFAULT_HOST = 'http://www.example.com'
