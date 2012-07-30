module Checkdin
  module Clients

    # Retrieve information about the authenticated client

    def client_details
      response = connection.get("clients/me")
      return_error_or_body(response)
    end
  end
end