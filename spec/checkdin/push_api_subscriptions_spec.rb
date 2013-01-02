require 'spec_helper'

describe Checkdin::PushApiSubscriptions do

  before do
    @client = Checkdin::Client.new(TestCredentials.client_args)
  end

  context "viewing a single push api subscription" do
    use_vcr_cassette
    let(:result) { @client.push_api_subscription(1) }

    it "should make the push API subscription's url available" do
      result.push_api_subscription.push_url.should == "http://test.com"
    end

    it "should make the push API subscription's push secret available" do
      result.push_api_subscription.secret.should == "6dec79a3034468c530fc"
    end
  end

  context "viewing a list of push api subscriptions" do
    use_vcr_cassette
    let(:result) { @client.push_api_subscriptions }

    it "should make a list of push API subscriptions available" do
      result.count.should == 2
    end
  end

  context "enabling a push api subscription" do
    use_vcr_cassette
    let(:result) { @client.enable_push_api_subscription(2) }

    it "should enable the subscription and return it" do
      result.push_api_subscription.state.should == "enabled"
    end
  end

  context "disabling a push api subscription" do
    use_vcr_cassette
    let(:result) { @client.disable_push_api_subscription(1) }

    it "should disable the subscription and return it" do
      result.push_api_subscription.state.should == "disabled"
    end
  end


end