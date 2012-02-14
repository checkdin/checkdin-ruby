module Checkdin
  class APIError < StandardError

    attr_reader :response
    attr_reader :status

    def initialize(status, response)
      @status   = status
      @response = response
    end

    def message
      "Status Code #{@status}: #{@response}"
    end
  end
end