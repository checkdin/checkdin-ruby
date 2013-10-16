require 'spec_helper'

describe Checkdin::Clients do

  before do
    @client = Checkdin::Client.new(TestCredentials.client_args)
  end

  context "viewing a client's own information", :vcr do
    let(:result) { @client.client_details }

    it "should make the client's information available" do
      result.client.name.should == "Favorite client"
      result.client.website.should == "http://example.com"
      result.client.signup_redirect.should == "http://your-site.com/user-signed-up"
      result.client.custom_domain.should == "custom.staging.checkd.in"
      result.client.shared_authentication_secret.should == "sweet-monkeybreath"
      result.client.push_api_secret.should be_nil
    end

  end
end