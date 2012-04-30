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

    it "takes an optional api_url" do
      instance = Checkdin::Client.new(:api_url => 'https://bogus.checkd.in/api/v7')
      instance.api_url.should == 'https://bogus.checkd.in/api/v7'
    end

    it "raises an error when an unknown option is passed" do
      expect {
        Checkdin::Client.new(:unexpected_present => 'details here')
      }.to raise_error(ArgumentError, /unexpected_present/)
    end
  end
end
