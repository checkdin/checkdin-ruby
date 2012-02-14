module Checkdin
  module Campaigns

    # Retrieve information about a campaign
    #
    # param [Integer] id The ID of the campaign

    def campaign(id)
      response = connection.get("campaigns/#{id}")
      return_error_or_body(response, response.body.campaign)
    end
  end
end
