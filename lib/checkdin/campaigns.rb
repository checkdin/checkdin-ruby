module Checkdin
  module Campaigns

    # Retrieve information about a campaign
    #
    # param [Integer] id The ID of the campaign

    def campaign(id)
      response = connection.get("campaigns/#{id}")
      return_error_or_body(response, response.body.campaign)
    end

    # Get a list of all campaigns for the authenticating client.
    #
    # @param [Hash]  options
    # @option options Integer :limit - The maximum number of records to return.

    def campaigns(options={})
      response = connection.get do |req|
      	req.url "campaigns", options
      end
      return_error_or_body(response, response.body)
  	end

  end
end
