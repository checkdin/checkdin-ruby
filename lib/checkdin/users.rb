module Checkdin
  module Users

    # Retrieve information about a single user
    #
    # param [Integer] id The ID of the user

    def user(id)
      response = connection.get("users/#{id}")
      return_error_or_body(response)
    end

    # Get a list of all users for the authenticating client.
    #
    # @param [Hash]  options
    # @option options Integer :limit - The maximum number of records to return.

    def users(options={})
      response = connection.get do |req|
        req.url "users", options
      end
      return_error_or_body(response)
    end

    # Lookup the checkd.in ID of a user based on their whitelabel ID.
    #
    # params [Integer] id The whitelabel identifier of the user (passed to checkd.in during creation)

    def whitelabel_user_lookup(id)
      response = connection.get("users/whitelabel/#{id}")
      return_error_or_body(response)
    end

  end
end