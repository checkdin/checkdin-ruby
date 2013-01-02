require 'forwardable'

module Checkdin
  class Client
    extend Forwardable

    include Campaigns
    include Promotions
    include WonRewards
    include Activities
    include Users
    include CustomActivities
    include Leaderboard
    include Votes
    include Clients
    include PushApiSubscriptions

    attr_reader :client_id, :client_secret
    attr_reader :ssl
    # Base URL for api requests.
    attr_reader :api_url

    DEFAULT_API_URL = "https://app.checkd.in/api/v1"

    #Initialize the client class that will be used for all checkd.in API requests.  Requires a valid client_id and client_secret - more info at http://developer.checkd.in
    #
    #
    # @param [Hash] options
    # @option options String :client_id Your foursquare app's client_id
    # @option options String :client_secret Your foursquare app's client_secret
    # @option options String :api_url A custom API url, does not usually have to be overridden
    # @option options Hash   :ssl Additional SSL options (like the path to certificate file)

    def initialize(options={})
      @client_id     = options.delete(:client_id)
      @client_secret = options.delete(:client_secret)
      @api_url       = options.delete(:api_url) || DEFAULT_API_URL
      @ssl           = options.delete(:ssl) || {}

      raise ArgumentError.new("Unexpected argument given: #{options.inspect}") unless options.blank?
    end

    # Sets up the connection to be used for all requests based on options passed during initialization.
    def connection
      @connection ||= begin
        params = {
          :client_id     => client_id,
          :client_secret => client_secret
        }

        Faraday::Connection.new(:url => api_url, :ssl => ssl, :params => params, :headers => default_headers) do |builder|
          builder.use Faraday::Request::Multipart
          builder.use Faraday::Request::UrlEncoded

          builder.use FaradayMiddleware::Mashify
          builder.use FaradayMiddleware::ParseJson

          builder.adapter Faraday.default_adapter
        end
      end
    end

    # Helper method to return errors or desired response data as appropriate.
    #
    # Added just for convenience to avoid having to traverse farther down the response just to get to returned data.

    def return_error_or_body(response)
      if response.status == 200
        response.body
      else
        raise Checkdin::APIError.new(response.status, response.body)
      end
    end

    private


    def default_headers
      headers = {
        :accept =>  'application/json',
        :user_agent => "checkdin ruby gem #{Checkdin::VERSION}"
      }
    end

  end
end
