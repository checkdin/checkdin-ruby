module Checkdin
  module Promotions

    # Retrieve information about a promotion
    #
    # param [Integer] id The ID of the promotion

    def promotion(id)
      response = connection.get("promotions/#{id}")
      return_error_or_body(response)
    end

    # Get a list of all promotions for the authenticating client.
    #
    # @param [Hash]  options
    # @option options Integer :campaign_id - Only return promotions for this campaign.
    # @option options String :active - Return either active or inactive promotions, use true or false value.
    # @option options Integer :limit - The maximum number of records to return.

    def promotions(options={})
      response = connection.get do |req|
        req.url "promotions", options
      end
      return_error_or_body(response)
    end

    # Get a list of activities for a promotion ordered by the number of votes they have received
    #
    # param [Integer] id The ID ofthe promotion
    # @param [Hash]  options
    # @option options Integer :limit - The maximum number of records to return.
    # @option options Integer :page - The page of results to return.

    def promotion_votes_leaderboard(id, options={})
      response = connection.get do |req|
        req.url "promotions/#{id}/votes_leaderboard", options
      end
      return_error_or_body(response)
    end

  end
end
