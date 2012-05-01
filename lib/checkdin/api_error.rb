module Checkdin
  class APIError < StandardError

    attr_reader :status, :body

    def initialize(status, body)
      @status   = status
      @body     = body
    end

    def message
      "Status Code: #{status}\nBody: #{body}"
    end
  end
end
