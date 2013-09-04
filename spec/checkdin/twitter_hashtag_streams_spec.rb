require 'spec_helper'

describe Checkdin::TwitterHashtagStreams do

  before do
    @client = Checkdin::Client.new(TestCredentials.client_args)
  end


  context "viewing twitter hashtag streams for a specific campaign" do
    use_vcr_cassette
    let(:result) { @client.twitter_hashtag_streams(58) }

    it "should provide a list of twitter hashtag streams" do
      result.twitter_hashtag_streams.first.twitter_hashtag_stream.twitter_hashtag.should == "#monkeyfur"
      result.twitter_hashtag_streams.first.twitter_hashtag_stream.hashtag_twitter_statuses_count.should == 50
      result.twitter_hashtag_streams.count.should == 2
    end
  end

  context "viewing a single twitter hashtag stream for a campaign" do
    use_vcr_cassette
    let(:twitter_hashtag_stream_id){ 3 }
    let(:result) { @client.twitter_hashtag_stream(58, twitter_hashtag_stream_id) }

    it "should provide a single twitter_hashtag_stream" do
      result.twitter_hashtag_stream.hashtag_twitter_statuses_count.should == 1345
      result.twitter_hashtag_stream.twitter_hashtag.should == "#banana"
    end
  end

end