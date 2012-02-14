require 'faraday'
require 'faraday_middleware'

directory = File.expand_path(File.dirname(__FILE__))

module Checkdin

  require 'checkdin/client'
  require 'checkdin/api_error'
  require 'checkdin/campaigns'

end