module Checkdin
  module CustomActivities

    # Notify checkd.in of a custom activity ocurring
    #
    # @param [Hash]  options
    # @option options Integer :custom_activity_node_id - The ID of the custom activity node that has ocurred, available in checkd.in admin. Required.
    # @option options Integer :user_id - The ID of the user that has performed the custom activity - either this or email is required.
    # @option options String  :email - The email address of the user that has performed the custom activity - either this or user_id is required.

    def create_custom_activity(options={})
      response = connection.post do |req|
        req.url "custom_activities", options
      end
      return_error_or_body(response)
    end

  end
end