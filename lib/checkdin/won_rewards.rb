module Checkdin
  module WonRewards

    # Retrieve information about a won reward
    #
    # param [Integer] id The ID of the reward

    def won_reward(id)
      response = connection.get("won_rewards/#{id}")
      return_error_or_body(response)
    end

    # Get a list of all won rewards for the authenticating client.
    #
    # @param [Hash]  options
    # @option options Integer :campaign_id - Only return won rewards for this campaign.
    # @option options Integer :user_id - Only return won rewards for this user.
    # @option options Integer :promotion_id - Only return won rewards for this promotion.
    # @option options Integer :limit - The maximum number of records to return.

    def won_rewards(options={})
      response = connection.get do |req|
        req.url "won_rewards", options
      end
      return_error_or_body(response)
    end

    # Retract a won reward - this will also create a corresponding negative points entry if needed.
    #
    # param [Integer] id The ID of the reward

    def retract_won_reward(id)
      response = connection.post("won_rewards/#{id}/retract")
      return_error_or_body(response)
    end
  end
end