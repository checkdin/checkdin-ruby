module Checkdin
  class APIError < StandardError

    attr_reader :status

    def initialize(status)
      @status   = status
    end

    def message
      "Status Code: #{@status}"
    end
  end
end