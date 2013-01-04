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

    # Create a user in the checkd.in system tied to the authenticating client.
    #
    # @param [Hash]  options
    # @option options String :identifier            - REQUIRED, The authenticating client's internal identifier for this user.
    # @option options String :email                 - REQUIRED, A valid email for the user
    # @option options String :referral_token        - OPTIONAL, the referral token of the user that referred the user being created.
    # @option options String :first_name            - OPTIONAL
    # @option options String :last_name             - OPTIONAL
    # @option options String :gender                - OPTIONAL, format of male or female
    # @option options String :birth_date            - OPTIONAL, YYYY-MM-DD format
    # @option options String :username              - OPTIONAL
    # @option options String :mobile_number         - OPTIONAL, XXXYYYZZZZ format
    # @option options String :postal_code_text      - OPTIONAL, XXXXX format
    # @option options String :classification        - OPTIONAL, the internal group or classification a user belongs to
    # @option options Boolean :delivery_email       - OPTIONAL, whether a user should receive email notifications
    # @option options Boolean :delivery_sms         - OPTIONAL, whether a user should receive sms notifications
    # @option options Integer :campaign_id          - OPTIONAL, automatically join a user to this campaign, rewarding existing known actions

    def create_user(options={})
      response = connection.post do |req|
        req.url "users", options
      end
      return_error_or_body(response)
    end

    # Retrieve a list of a user's authentications to external services (Facebook, Foursquare, etc.)
    #
    # param [Integer] id The ID of the user

    def user_authentications(id)
      response = connection.get("users/#{id}/authentications")
      return_error_or_body(response)
    end

    # Retrieve information about a user's specific authentication to an external service
    #
    # param [Integer] user_id The ID of the user
    # param [Integer] id The ID of the authentication

    def user_authentication(user_id, id)
      response = connection.get("users/#{user_id}/authentications/#{id}")
      return_error_or_body(response)
    end

    # Create an authentication for a user
    #
    # param [Integer] id The ID of the user
    # @param [Hash]  options
    # @option options String :provider - The name of the provider for the authentication (twitter, facebook, foursquare, linkedin, instagram)
    # @option options String :uid - The user's id for the provider (on the provider's service, not your internal identifier)
    # @option options String :oauth_token - The user's oauth token or access token that can be used to retrieve data on their behalf on the service.
    # @option options String :oauth_token_secret - The user's oauth token secret or access token secret that is used in combination with the oauth token (required for twitter)
    # @option options String :nickname - The user's nickname on the provider's service.

    def create_user_authentication(id, options={})
      response = connection.post do |req|
        req.url "users/#{id}/authentications", options
      end
      return_error_or_body(response)
    end

    # Get a list of all blacklisted users for the authenticating client.
    #
    # @param [Hash]  options
    # @option options Integer :limit - The maximum number of records to return.

    def blacklisted(options={})
      response = connection.get do |req|
        req.url "users/blacklisted", options
      end
      return_error_or_body(response)
    end

    # Blacklist user from creating activities
    #
    # param [Integer] id The ID of the user

    def blacklist(id)
      response = connection.put("users/#{id}/blacklist")
      return_error_or_body(response)
    end

    # Whitelist user that has been blacklisted
    #
    # param [Integer] id The ID of the user

    def whitelist(id)
      response = connection.delete("users/#{id}/blacklist")
      return_error_or_body(response)
    end

  end
end