require 'forwardable'

module Checkdin
  class Client
    extend Forwardable

    include Campaigns

    attr_reader :client_id, :client_secret

    #Initialize the client class that will be used for all checkd.in API requests.  Requires a valid client_id and client_secret - more info at http://developer.checkd.in
    #
    #
    # @param [Hash] options
    # @option options String :client_id Your foursquare app's client_id
    # @option options String :client_secret Your foursquare app's client_secret
    # @option options Hash   :ssl Additional SSL options (like the path to certificate file)
    
    def initialize(options={})
      @client_id = options[:client_id]
      @client_secret = options[:client_secret]
      @ssl = options[:ssl].nil? ? Hash.new : options[:ssl]
    end
    
    def ssl
      @ssl
    end
    
    # Sets up the connection to be used for all requests based on options passed during initialization.

    def connection
      params = {}
      params[:client_id] = @client_id
      params[:client_secret] = @client_secret
      @connection ||= Faraday::Connection.new(:url => api_url, :ssl => @ssl, :params => params, :headers => default_headers) do |builder|
        builder.use Faraday::Request::Multipart
        builder.use Faraday::Request::UrlEncoded

        builder.use FaradayMiddleware::Mashify
        builder.use FaradayMiddleware::ParseJson

        builder.adapter Faraday.default_adapter

      end
    end

    # Base URL for api requests.

    def api_url
      "https://app.checkd.in/api/v1"
    end

    # Helper method to return errors or desired response data as appropriate.
    #
    # Added just for convenience to avoid having to traverse farther down the response just to get to returned data.

    def return_error_or_body(response, response_body)
      if response.status == 200 
        response_body
      else
        raise Checkdin::APIError.new(response.status)
      end
    end
      
    private


    def default_headers
      headers = {
        :accept =>  'application/json',
        :user_agent => 'Ruby gem'
      }
    end

  end
end