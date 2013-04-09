require 'spec_helper'

describe Checkdin::APIError do
  it "stores a message" do
    instance = Checkdin::APIError.new(404, 'Response body here')
    instance.message.should eq('status_code:404 body:"Response body here"')
  end

  it "outputs a helpful form of .to_s" do
    instance = Checkdin::APIError.new(503, '{"body":"nested"}')
    expected = 'status_code:503 body:"{\"body\":\"nested\"}"'
    instance.to_s.should eq(expected)
  end

  it "is also useful when calling .inspect" do
    instance = Checkdin::APIError.new(401, 'trivial')
    expected = '#<Checkdin::APIError: status_code:401 body:"trivial">'
    instance.inspect.should eq(expected)
  end
end