require 'webmock/rspec'
require 'vcr'

# Disallow all HTTP connections
WebMock.disable_net_connect!

# VCR is used for recording and replaying known API HTTP interactions
VCR.configure do |config|
  config.cassette_library_dir = File.join('spec', 'fixtures', 'vcr_cassettes')

  config.hook_into :webmock

  config.configure_rspec_metadata!

  config.filter_sensitive_data('{client_id}')     { TestCredentials.client_id }
  config.filter_sensitive_data('{client_secret}') { TestCredentials.client_secret }
  config.filter_sensitive_data('{api_url}')       { TestCredentials.api_url }

  # ignore hostname when finding a matching request in the VCR recording
  config.default_cassette_options[:match_requests_on] = [ :method, :path ]
end