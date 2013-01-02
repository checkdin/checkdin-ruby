module Checkdin
  module PushApiSubscriptions

    # Retrieve information about a push API subscription
    #
    # param [Integer] id The ID of the subscription

    def push_api_subscription(id)
      response = connection.get("push_api_subscriptions/#{id}")
      return_error_or_body(response)
    end

    # Get a list of all push api subscriptions for the authenticating client.

    def push_api_subscriptions
      response = connection.get("push_api_subscriptions")
      return_error_or_body(response)
    end

    # Enable a push API subscription
    #
    # param [Integer] id The ID of the subscription to enable

    def enable_push_api_subscription(id)
      response = connection.put("push_api_subscriptions/#{id}/enable")
      return_error_or_body(response)
    end

    # Disable a push API subscription
    #
    # param [Integer] id The ID of the subscription to disable

    def disable_push_api_subscription(id)
      response = connection.put("push_api_subscriptions/#{id}/disable")
      return_error_or_body(response)
    end

  end
end