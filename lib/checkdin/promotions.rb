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
    # param [Integer] id The ID of the promotion
    # @param [Hash]  options
    # @option options Integer :limit - The maximum number of records to return.
    # @option options Integer :page - The page of results to return.

    def promotion_votes_leaderboard(id, options={})
      response = connection.get do |req|
        req.url "promotions/#{id}/votes_leaderboard", options
      end
      return_error_or_body(response)
    end

    # Create a promotion for campaign
    # param [String] promotion_short_name The promotion_type eg: custom_activity or twitter_activity
    # param [Integer] campaign_id - The ID of the campaign
    # param [Hash]  promotion - promotion create paramaters
    #   @param [Hash] options
    #   @option options String :title
    #   @option options String :participant_status_message
    #   @option options Hash :custom_activity_node - If custom_activity
    #     @option custom_activity_node String :name
    #   @option options Hash :trigger_schedule
    #     @options trigger_schedule String :winner_picked
    #     @options trigger_schedule String :rewarding
    #     @options trigger_schedule Integer :interval
    #   @option options Hash :reward
    #     @options reward String :type
    #     @options reward Integer :reward_points

    def create_promotion(promotion_short_name, options={})
      response = connection.post do |req|
        req.url "promotions/#{promotion_short_name}", options
      end
      return_error_or_body(response)
    end

  end
end
