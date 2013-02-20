module Checkdin
  module Leaderboard

    # Get the leading point accounts for non-campaign-specific points.
    #
    # @param [Hash]  options
    # @option options Integer :limit - The maximum number of records to return.
    
    def leaderboard(options={})
      response = connection.get do |req|
        req.url "clients/leaderboard", options
      end
      return_error_or_body(response)
    end

    # Get the leading point accounts for a single campaign'sc specific points.
    #
    # param [Integer] campaign_id The ID of the campaign to fetch the leaderboard for.
    # @param [Hash]  options
    # @option options Integer :limit - The maximum number of records to return.

    def campaign_leaderboard(campaign_id, options={})
      response = connection.get do |req|
        req.url "campaigns/#{campaign_id}/leaderboard"
      end
      return_error_or_body(response)
    end

    # Get the classification leaderboard for a given campaign
    #
    # param [Integer] campaign_id The ID of the campaign to fetch the leaderboard for.

    def classification_leaderboard(campaign_id)
      response = connection.get do |req|
        req.url "campaigns/#{campaign_id}/classification_leaderboard"
      end
      return_error_or_body(response)
    end

  end
end