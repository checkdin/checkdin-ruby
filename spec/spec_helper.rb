require 'rubygems'
require 'simplecov'
SimpleCov.start do
  add_filter "/spec"
end
require 'checkdin'
require 'rspec'

require 'webmock/rspec'
require 'vcr'

# Disallow all HTTP connections
WebMock.disable_net_connect!

# VCR is used for recording and replaying known API HTTP interactions
VCR.config do |config|
  config.cassette_library_dir = File.join('spec', 'fixtures', 'vcr_cassettes')

  config.stub_with :webmock
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