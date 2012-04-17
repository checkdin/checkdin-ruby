require 'spec_helper'

describe Checkdin::Votes do

  before do
    @client = Checkdin::Client.new(:client_id => '123456', :client_secret => '7890')
  end

  context "viewing a list of votes" do
    use_vcr_cassette
    let(:result) { @client.votes }

    it "should show a list of results" do
      result.votes.count.should == 7
    end

    it "should include the activity the vote was for" do
      result.votes.first.vote.activity.id.should == 18881
    end

    it "should include the user that voted" do
      result.votes.first.vote.user.id.should == 36
    end
  end

  context "filtering by a single user" do
    use_vcr_cassette
    let(:result) { @client.votes(:user_id => 36) }

    it "should show a list of results for the user" do
      result.votes.count.should == 3
    end

    it "should only show votes belonging to the user" do
      result.votes.collect{|v| v.vote.user.id }.should == [36,36,36]
    end
  end
end