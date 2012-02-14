require 'spec_helper'

describe Checkdin::CustomActivities do
  use_vcr_cassette

  before do
    @client = Checkdin::Client.new(:client_id => '123456', :client_secret => '7890')
  end

  it "should report success when creating a custom activity" do
    @client.create_custom_activity(:email => 'muellermr@gmail.com', :custom_activity_node_id => 1).result.should == "success"
  end
end
