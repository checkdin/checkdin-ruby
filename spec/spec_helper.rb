require 'rubygems'
require 'simplecov'
SimpleCov.start do
  add_filter "/spec"
end
require 'checkdin'
require 'rspec'

Dir["./spec/support/**/*.rb"].each {|f| require f}
