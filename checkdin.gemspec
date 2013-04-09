# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "checkdin/version"

Gem::Specification.new do |s|
  s.name = "checkdin"
  s.version = Checkdin::VERSION
  s.authors = ["Matt Mueller"]
  s.date = "2012-03-11"
  s.description = "Ruby gem for interacting with the checkd.in API.  See http://checkd.in or http://developer.checkd.in for more information."
  s.email = "muellermr@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    "Gemfile",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "lib/checkdin.rb",
    "lib/checkdin/activities.rb",
    "lib/checkdin/api_error.rb",
    "lib/checkdin/campaigns.rb",
    "lib/checkdin/client.rb",
    "lib/checkdin/custom_activities.rb",
    "lib/checkdin/leaderboard.rb",
    "lib/checkdin/point_account_entries.rb",
    "lib/checkdin/promotions.rb",
    "lib/checkdin/push_api_subscriptions.rb",
    "lib/checkdin/users.rb",
    "lib/checkdin/user_bridge.rb",
    "lib/checkdin/version.rb",
    "lib/checkdin/votes.rb",
    "lib/checkdin/clients.rb",
    "lib/checkdin/won_rewards.rb"
  ]
  s.files += Dir['spec/']
  s.homepage = "http://github.com/mattmueller/checkdin-ruby"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Ruby gem for interacting with the checkd.in API."

  s.add_runtime_dependency 'faraday', '~> 0.8'
  s.add_runtime_dependency 'faraday_middleware'
  s.add_runtime_dependency 'hashie', '~> 1.0'
  s.add_runtime_dependency 'activesupport', '>= 2.0.3'

  s.add_development_dependency "rspec", "~> 2.8.0"
  s.add_development_dependency "rdoc", "~> 3.12"
  s.add_development_dependency "bundler", "~> 1.0"
  s.add_development_dependency "simplecov", '~> 0.5.4'
  s.add_development_dependency "webmock", "~> 1.7.10"
  s.add_development_dependency "vcr", "~> 1.11.3"
  s.add_development_dependency "timecop"
  s.add_development_dependency "rake"
end
