module Checkdin
  class UserBridge
    CHECKDIN_DEFAULT_LANDING = 'https://app.checkd.in/user_landing?'

    attr :client_identifier, :bridge_secret
    attr :checkdin_landing_url

    # Used to build the authenticated parameters for logging in an end-user on 
    # checkd.in via a redirect.
    #
    # options              - a hash with a the following values defined:
    #   :client_identifier - REQUIRED, the same client identifier used when accessing the regular
    #                        API methods.
    #   :bridge_secret     - REQUIRED, previously agreed upon shared secret for the user bridge.
    #                        This is NOT the shared secret used for accessing the backend API,
    #                        please do not confuse the two.
    #   :checkdin_landing_url - OPTIONAL, the value will default to CHECKDIN_DEFAULT_LANDING
    #                           if not given. Please set this value as directed by Checkd In.
    #
    # Examples
    #
    #   bridge = Checkdin::UserBridge.new(:client_identifier => 'YOUR_ASSIGNED_CLIENT_IDENTIFIER',
    #                                     :bridge_secret     => 'YOUR_ASSIGNED_BRIDGE_SECRET')
    #   redirect_to bridge.login_url(:email           => 'bob@example.com',
    #                                :user_identifier => '112-fixed-user-identifier')
    #
    def initialize options
      @client_identifier = options.delete(:client_identifier) or raise ArgumentError.new("No :client_identifier given")
      @bridge_secret     = options.delete(:bridge_secret)     or raise ArgumentError.new("No :bridge_secret given")

      @checkdin_landing_url = options.delete(:checkdin_landing_url) || CHECKDIN_DEFAULT_LANDING

      raise ArgumentError.new("Unknown arguments given: #{options.keys.inspect}") unless options.empty?
    end

    # Public: Build a full signed url for logging a specific user into checkd.in. Notice:
    # you MUST NOT reuse the result of this method, as it expires automatically based on time.
    #
    # options                 - a hash with the following values defined:
    #   email                 - REQUIRED, email address of the user, MAY have different values for a given
    #                           user over time.
    #   user_identifier       - REQUIRED, your unique identifier for the user, MUST NOT change over time.
    #   authentication_action - OPTIONAL, the given action will be performed immediately,
    #                           and the user redirected back to your site afterwards.
    #
    # Returns a URL you can use for redirecting a user. Notice this will expire, so it should
    # be generated and used only when a user actually wants to log into checkd.in.
    def login_url options
      email                 = options.delete(:email)           or raise ArgumentError.new("No :email passed for user")
      user_identifier       = options.delete(:user_identifier) or raise ArgumentError.new("No :user_identifier passed for user")
      authentication_action = options.delete(:authentication_action)

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
        'client_id'      => client_identifier,
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
