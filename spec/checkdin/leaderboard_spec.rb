require 'spec_helper'

describe Checkdin::Leaderboard do

  before do
    @client = Checkdin::Client.new(TestCredentials.client_args)
  end

  context "viewing a leaderboard for a campaign" do
    use_vcr_cassette
    let(:result) { @client.leaderboard(2, :limit => 5) }

    it "should provide a list of users" do
      result.leaders.first.leader.username.should == "hshapley"
      result.leaders.count.should == 5
    end
  end
end
