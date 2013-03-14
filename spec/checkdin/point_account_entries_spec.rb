require 'spec_helper'

describe Checkdin::PointAccountEntries do

  before do
    @client = Checkdin::Client.new(TestCredentials.client_args)
  end

  context "viewing a list of point account entries" do
    use_vcr_cassette
    let(:result) { @client.point_account_entries }

    it "should make a list of point account entries available" do
      result.point_account_entries.count.should == 1
      result.point_account_entries.first.point_account_entry.point_value.should == 1
    end
  end
end