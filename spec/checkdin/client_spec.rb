require 'spec_helper'

describe Checkdin::Client do
  context "creating a new instance" do

    it "should have a method for creating a new instance" do
      Checkdin::Client.respond_to?(:new).should be_true
    end

    it "should be a Checkdin::Client" do
      Checkdin::Client.new.should be_a(Checkdin::Client)
    end

    it "has the version available" do
      Checkdin::VERSION.should =~ /^\d\.\d\.\d/
    end
  end
end