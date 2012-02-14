require 'spec_helper'

describe Checkdin::Promotions do

  before do
    @client = Checkdin::Client.new(:client_id => '123456', :client_secret => '7890')
  end

  context "viewing a single promotion" do
    use_vcr_cassette
    let(:result) { @client.promotion(8) }

    it "should make the promotion's information available" do
      result.promotion.title.should == "Get a FREE coffee for every 5 check ins!"
    end

    it "should make the promotion's campaign available" do
      result.promotion.campaign.name.should == "Check In To Win"
    end
  end

  context "viewing a list of promotions" do
    use_vcr_cassette
    let(:result) { @client.promotions(:limit => 2) }

    it "should make a list of promotion info available" do
      promotion_names = result.promotions.collect{|p| p.promotion.title}
      promotion_names.should == ["Get a FREE coffee for every 5 check ins!","Check in and get breakfast for 99 cents!"]
    end

    it "should only return the right number of results" do
      result.count.should == 2
    end
  end
end