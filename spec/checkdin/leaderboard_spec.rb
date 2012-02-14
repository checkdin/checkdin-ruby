require 'spec_helper'

describe Checkdin::Leaderboard do

  before do
    @client = Checkdin::Client.new(:client_id => '123456', :client_secret => '7890')
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