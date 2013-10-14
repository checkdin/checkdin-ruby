require 'spec_helper'

describe Checkdin::Leaderboard do

  before do
    @client = Checkdin::Client.new(TestCredentials.client_args)
  end

  context "viewing a leaderboard for the client", :vcr do
    let(:result) { @client.leaderboard(:limit => 5) }

    it "should provide a list of point accounts" do
      result.point_accounts.first.point_account.user.username.should == "primero"
      result.point_accounts.first.point_account.balance.should == 50
      result.point_accounts.count.should == 1
    end
  end

  context "viewing a leaderboard for a specific campaign", :vcr do
    let(:result) { @client.campaign_leaderboard(1) }

    it "should provide a list of point accounts" do
      result.point_accounts.first.point_account.user.username.should == "primero"
      result.point_accounts.first.point_account.balance.should == 71
      result.point_accounts.count.should == 1
    end
  end

  context "viewing a leaderboard for a campaign's classifications", :vcr do
    let(:result) { @client.classification_leaderboard(1) }

    it "should provide a list of classifications" do
      result.classifications.first.classification.should == "mugglers"
      result.classifications.first.total_points.should == 71
    end
  end
end

