require 'spec_helper'

describe Checkdin::WonRewards do

  before do
    @client = Checkdin::Client.new(:client_id => '123456', :client_secret => '7890')
  end

  context "viewing a single won reward" do
    use_vcr_cassette
    let(:result) { @client.won_reward(142) }

    it "should make the won rewards' information available" do
      result.won_reward.private_delivery_description.should == "Thank you"
    end

    it "should make the won rewards' promotion available" do
      result.won_reward.promotion.title.should == "A great promotion"
    end
  end

  context "viewing a list of won rewards" do
    use_vcr_cassette
    let(:result) { @client.won_rewards(:limit => 2) }

    it "should make a list of won rewards available" do
      won_reward_delivery_descriptions = result.won_rewards.collect{|wr| wr.won_reward.private_delivery_description}
      won_reward_delivery_descriptions.should == ["Thank you","Thank you"]
    end

    it "should only return the right number of results" do
      result.count.should == 2
    end
  end
end