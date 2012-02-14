require 'faraday'
require 'faraday_middleware'

directory = File.expand_path(File.dirname(__FILE__))

module Checkdin

  require 'checkdin/leaderboard'
  require 'checkdin/custom_activities'
  require 'checkdin/users'
  require 'checkdin/activities'
  require 'checkdin/won_rewards'
  require 'checkdin/promotions'
  require 'checkdin/campaigns'
  require 'checkdin/client'
  require 'checkdin/api_error'


end