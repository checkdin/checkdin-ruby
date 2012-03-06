module Checkdin
  class UserBridge
    CHECKDIN_DEFAULT_LANDING = 'https://app.checkd.in/user_landing?'

    attr :client_id, :bridge_secret

    # Public: Used for setting the URL which login requests go to, defaults to CHECKDIN_DEFAULT_LANDING.
    # Please set this value as directed by Checkd In.
    #
    # Example:
    #
    #   bridge = Checkdin::UserBridge.new(...)
    #   bridge.checkdin_landing_url = 'https://client-name.checkd.in/user_landing?'
    #
    attr_accessor :checkdin_landing_url

    # Used to build the authenticated parameters for logging in an end-user on 
    # checkd.in via a redirect.
    #
    # client_id     - the same client identifier used when accessing the regular API methods.
    # bridge_secret - previously agreed upon shared secret for the user bridge. This is NOT
    #                 the shared secret used for accessing the backend API, please do not
    #                 confuse the two.
    #
    # Examples
    #
    #   bridge = Checkdin::UserBridge.new('YOUR_ASSIGNED_CLIENT_IDENTIFIER', 'YOUR_ASSIGNED_BRIDGE_SECRET')
    #   redirect_to bridge.login_url('bob@example.com', '112-fixed-user-identifier')
    #
    def initialize client_id, bridge_secret
      @client_id     = client_id
      @bridge_secret = bridge_secret

      @checkdin_landing_url = CHECKDIN_DEFAULT_LANDING
    end

    # Public: Build a full signed url for logging a specific user into checkd.in. Notice:
    # you MUST NOT reuse the result of this method, as it expires automatically based on time.
    #
    # email                 - email address of the user, MAY have different values for a given
    #                         user over time.
    # user_identifier       - your unique identifier for the user, MUST NOT change over time.
    # authentication_action - OPTIONAL, the given action will be performed immediately,
    #                         and the user redirected back to your site afterwards.
    #
    # Returns a URL you can use for redirecting a user. Notice this will expire, so it should
    # be generated and used only when a user actually wants to log into checkd.in.
    def login_url email, user_identifier, authentication_action = nil
      authenticated_parameters = build_authenticated_parameters(email, user_identifier, authentication_action)

      [checkdin_landing_url, authenticated_parameters.to_query].join
    end

    # Private: Build a signed hash of parameters for redirecting the user to checkd.in.
    #
    # Returns a hash including a secure message digest and the current timestamp
    def build_authenticated_parameters email, user_identifier, authentication_action = nil
      build_request(email, user_identifier, authentication_action).tap do |request|
        request['digest'] = digest_request(request)
      end
    end

    private
    def build_request email, user_identifier, authentication_action
      {
        'auth_timestamp' => Time.now.to_i,
        'client_id'      => client_id,
        'client_uid'     => user_identifier,
        'email'          => email,
      }.tap do |request|
        request['authentication_action'] = authentication_action if authentication_action
      end
    end

    def digest_request request
      encoded_request = request.to_query
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA256.new, bridge_secret, encoded_request)
    end

  end
end
