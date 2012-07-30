require 'spec_helper'

describe Checkdin::Clients do

  before do
    @client = Checkdin::Client.new(TestCredentials.client_args)
  end

  context "viewing a client's own information" do
    use_vcr_cassette
    let(:result) { @client.client_details }

    it "should make the client's information available" do
      result.client.name.should == "A Test"
      result.client.website.should == "http://example.com"
      result.client.signup_redirect.should == "http://example.com/users/return_from_checkdin"
      result.client.custom_domain.should == "custom.staging.checkd.in"
      result.client.shared_authentication_secret.should == "12345"
      result.client.push_api_secret.should be_nil
    end

  end
end