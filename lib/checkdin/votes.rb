module Checkdin
  module Votes

    # Get a list of all activities for the authenticating client.
    #
    # @param [Hash]  options
    # @option options Integer :user_id - Only return won rewards for this user.
    # @option options Integer :limit - The maximum number of records to return.

    def votes(options={})
      response = connection.get do |req|
        req.url "votes", options
      end
      return_error_or_body(response)
    end
  end
end