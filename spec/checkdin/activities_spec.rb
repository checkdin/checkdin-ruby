require 'spec_helper'

describe Checkdin::Activities do

  before do
    @client = Checkdin::Client.new(:client_id => '123456', :client_secret => '7890')
  end

  context "viewing a single activity" do
    use_vcr_cassette
    let(:result) { @client.activity(236) }

    it "should make the activity's information available" do
      result.activity.type.should == "lbs_checkin"
    end

    it "should make the activity's acted on information available" do
      result.activity.acted_on.type.should == "place"
      result.activity.acted_on.name.should == "My Shop"
    end

    it "should include the user for the activity" do
      result.activity.user.username.should == "krhoch"
    end
  end

  context "viewing a list of activities" do
    use_vcr_cassette
    let(:result) { @client.activities(:limit => 2) }

    it "should make a list of activities available" do
      activities_types = result.activities.collect{|a| a.activity.type}
      activities_types.should == ["lbs_checkin","lbs_checkin"]
    end

    it "should only return the right number of results" do
      result.activities.count.should == 2
    end

    it "should return the users" do
      activity_user_usernames = result.activities.collect{|a| a.activity.user.username }
      activity_user_usernames.should == ["krhoch", "krhoch"]
    end

  end
end