# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "checkdin/version"

Gem::Specification.new do |s|
  s.name = "checkdin"
  s.version = Checkdin::VERSION
  s.authors = ["Matt Mueller"]
  s.date = "2012-02-14"
  s.description = "Ruby gem for interacting with the checkd.in API.  See http://checkd.in or http://developer.checkd.in for more information."
  s.email = "muellermr@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
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
    "lib/checkdin/promotions.rb",
    "lib/checkdin/users.rb",
    "lib/checkdin/user_bridge.rb",
    "lib/checkdin/version.rb",
    "lib/checkdin/won_rewards.rb",
    "spec/checkdin/activities_spec.rb",
    "spec/checkdin/campaigns_spec.rb",
    "spec/checkdin/client_spec.rb",
    "spec/checkdin/custom_activities_spec.rb",
    "spec/checkdin/leaderboard_spec.rb",
    "spec/checkdin/promotions_spec.rb",
    "spec/checkdin/users_spec.rb",
    "spec/checkdin/user_bridge_spec.rb",
    "spec/checkdin/won_rewards_spec.rb",
    "spec/fixtures/vcr_cassettes/Checkdin_Activities/viewing_a_list_of_activities.yml",
    "spec/fixtures/vcr_cassettes/Checkdin_Activities/viewing_a_single_activity.yml",
    "spec/fixtures/vcr_cassettes/Checkdin_Campaigns/viewing_a_list_of_campaigns.yml",
    "spec/fixtures/vcr_cassettes/Checkdin_Campaigns/viewing_a_single_campaign.yml",
    "spec/fixtures/vcr_cassettes/Checkdin_CustomActivities.yml",
    "spec/fixtures/vcr_cassettes/Checkdin_Leaderboard/viewing_a_leaderboard_for_a_campaign.yml",
    "spec/fixtures/vcr_cassettes/Checkdin_Promotions/viewing_a_list_of_promotions.yml",
    "spec/fixtures/vcr_cassettes/Checkdin_Promotions/viewing_a_single_promotion.yml",
    "spec/fixtures/vcr_cassettes/Checkdin_Users/viewing_a_list_of_users.yml",
    "spec/fixtures/vcr_cassettes/Checkdin_Users/viewing_a_single_user.yml",
    "spec/fixtures/vcr_cassettes/Checkdin_WonRewards/viewing_a_list_of_won_rewards.yml",
    "spec/fixtures/vcr_cassettes/Checkdin_WonRewards/viewing_a_single_won_reward.yml",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/mattmueller/checkdin"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Ruby gem for interacting with the checkd.in API."

  s.add_runtime_dependency 'faraday', '>= 0.6', '< 0.8'
  s.add_runtime_dependency 'faraday_middleware', '>= 0.8'
  s.add_runtime_dependency 'hashie', '~> 1.0'
  s.add_runtime_dependency 'activesupport', '>= 2.0.3'

  s.add_development_dependency "rspec", "~> 2.8.0"
  s.add_development_dependency "rdoc", "~> 3.12"
  s.add_development_dependency "bundler", "~> 1.0.0"
  s.add_development_dependency "simplecov", '~> 0.5.4'
  s.add_development_dependency "webmock", "~> 1.7.10"
  s.add_development_dependency "vcr", "~> 1.11.3"
  s.add_development_dependency "timecop"
end
