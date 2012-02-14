require 'spec_helper'

describe Checkdin::Campaigns do

  before do
    @client = Checkdin::Client.new(:client_id => '123456', :client_secret => '7890')
  end

  context "viewing a single campaign" do
    use_vcr_cassette
    let(:result) { @client.campaign(2) }

    it "should make the campaign's information available" do
      result.name.should == "Check In To Win!"
    end

    it "should make the campaign's promotions available" do
      result.promotions.count.should == 1
      result.promotions.first.promotion.title.should == "Get a FREE coffee for every 5 check ins!"
    end
  end

  context "viewing a list of campaigns" do
    use_vcr_cassette
    let(:result) { @client.campaigns }

    it "should make a list of campaigns available" do
      result.count.should == 1
      result.first.campaign.name.should == "Check In To Win!"
    end
  end
end