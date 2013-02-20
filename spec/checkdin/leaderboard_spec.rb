require 'spec_helper'

describe Checkdin::Leaderboard do

  before do
    @client = Checkdin::Client.new(TestCredentials.client_args)
  end

  context "viewing a leaderboard for the client" do
    use_vcr_cassette
    let(:result) { @client.leaderboard(:limit => 5) }

    it "should provide a list of point accounts" do
      result.point_accounts.first.point_account.user.username.should == "leader"
      result.point_accounts.first.point_account.balance.should == 961
      result.point_accounts.count.should == 5
    end
  end

  context "viewing a leaderboard for a specific campaign" do
    use_vcr_cassette
    let(:result) { @client.campaign_leaderboard(8) }

    it "should provide a list of point accounts" do
      result.point_accounts.first.point_account.user.username.should == "leader"
      result.point_accounts.first.point_account.balance.should == 53
      result.point_accounts.count.should == 1
    end
  end  

  context "viewing a leaderboard for a campaign's classifications" do
    use_vcr_cassette
    let(:result) { @client.classification_leaderboard(8) }

    it "should provide a list of classifications" do
      result.classifications.first.classification.should == "grouped"
      result.classifications.first.total_points.should == 53
    end
  end
end
