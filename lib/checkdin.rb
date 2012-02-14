require 'faraday'
require 'faraday_middleware'

directory = File.expand_path(File.dirname(__FILE__))

module Checkdin

  require 'checkdin/campaigns'
  require 'checkdin/client'
  require 'checkdin/api_error'


end