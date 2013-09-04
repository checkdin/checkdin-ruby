module Checkdin
  module TwitterHashtagStreams

    # Retrieve Twitter Hashtag Streams for a campaign
    #
    # param [Integer] campaign_id The ID of the campaign to fetch the twitter hashtag stream for.
    # @param [Hash]  options

    def twitter_hashtag_streams(campaign_id, options={})
      response = connection.get do |req|
        req.url "campaigns/#{campaign_id}/twitter_hashtag_streams", options
      end
      return_error_or_body(response)
    end

    # Retrieve Single Twitter Hashtag Stream for a campaign
    #
    # param [Integer] campaign_id The ID of the campaign to fetch the twitter hashtag stream for.
    # param [Integer] id The ID of the twitter_hashtag_stream to fetch.
    # @param [Hash]  options

    def twitter_hashtag_stream(campaign_id, id, options={})
      response = connection.get do |req|
        req.url "campaigns/#{campaign_id}/twitter_hashtag_streams/#{id}", options
      end
      return_error_or_body(response)
    end

  end
end