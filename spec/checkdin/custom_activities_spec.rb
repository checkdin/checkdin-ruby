require 'spec_helper'

describe Checkdin::CustomActivities do
  use_vcr_cassette

  before do
    @client = Checkdin::Client.new(TestCredentials.client_args)
  end

  it "should report success when creating a custom activity" do
    @client.create_custom_activity(:email => 'muellermr@gmail.com', :custom_activity_node_id => 1).result.should == "success"
  end
end
