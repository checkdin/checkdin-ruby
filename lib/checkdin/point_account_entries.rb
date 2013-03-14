module Checkdin
  module PointAccountEntries

    # Get a list of point account entries.
    #
    # @param [Hash]  options
    # @option options Integer :user_id - Return entries only for this user
    # @option options Integer :campaign_id - Return entries only for this campaign
    # @option options Integer :point_account_id - Return entries only for this point account.
    # @option options Integer :limit - The maximum number of records to return.

    def point_account_entries(options={})
      response = connection.get do |req|
        req.url "point_account_entries", options
      end
      return_error_or_body(response)
    end

  end
end