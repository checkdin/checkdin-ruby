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

  context "viewing the votes leaderboard for a promotion" do
    use_vcr_cassette
    let(:result) { @client.promotion_votes_leaderboard(54, :limit => limit) }
    let(:limit) { nil }

    it "should return promotion information" do
      result.promotion.title.should == "A voting promotion!"
    end

    it "should return a list of activities ordered by vote count" do
      result.promotion.votes_leaderboard.activities.first.activity.vote_count.should == 7
      result.promotion.votes_leaderboard.activities.last.activity.vote_count.should == 0
    end

    it "should return all activities" do
      result.promotion.votes_leaderboard.activities.count.should == 3
    end

    context "limiting the number of records returned" do
      use_vcr_cassette
      let(:limit) { 1 }

      it "should only return limit number of records" do
        result.promotion.votes_leaderboard.activities.count.should == 1
      end
    end
  end
end