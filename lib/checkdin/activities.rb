module Checkdin
  module Activities

    # Retrieve information about a single activity
    #
    # param [Integer] id The ID of the activity

    def activity(id)
      response = connection.get("activities/#{id}")
      return_error_or_body(response)
    end

    # Get a list of all activities for the authenticating client.
    #
    # @param [Hash]  options
    # @option options Integer :campaign_id - Only return won rewards for this campaign.
    # @option options Integer :user_id - Only return won rewards for this user.
    # @option options Integer :since - Only fetch updates since this time (UNIX timestamp)
    # @option options Integer :limit - The maximum number of records to return.

    def activities(options={})
      response = connection.get do |req|
        req.url "activities", options
      end
      return_error_or_body(response)
    end

  end
end