require 'spec_helper'

describe Checkdin::Users do

  before do
    @client = Checkdin::Client.new(TestCredentials.client_args)
  end

  context "viewing a single user" do
    use_vcr_cassette
    let(:result) { @client.user(187) }

    it "should make the user's information available" do
      result.user.username.should == "krhoch"
    end

    it "should include the authentications for the user" do
      result.user.authentications.count.should == 1
    end
  end

  context "viewing a list of users" do
    use_vcr_cassette
    let(:result) { @client.users(:limit => 2) }

    it "should make a list of users available" do
      user_usernames = result.users.collect{|u| u.user.username}
      user_usernames.should == ["jclandes","krhoch"]
    end

    it "should only return the right number of results" do
      result.users.count.should == 2
    end

  end

  context "creating a user" do

    context "with valid parameters" do
      use_vcr_cassette
      let(:result) { @client.create_user(:email => 'atest@checkd.in', :identifier => 'clientuid123')}

      it "should return the new user's basic information" do
        result.user.should_not be_nil
      end
    end

    context "with an invalid email" do
      use_vcr_cassette

      it "should return error 400" do
        expect do
          @client.create_user(:email => 'notanemail', :identifier => 'client123')
        end.to raise_error(Checkdin::APIError, /400/)
      end
    end
  end

  context "viewing a single user's list of authentications" do
    use_vcr_cassette
    let(:result) { @client.user_authentications(7835) }

    it "should make a list of authentications available" do
      result.authentications.collect{ |a| a.authentication.provider }.should == ["twitter","facebook","foursquare"]
    end

    it "should include the user's uid" do
      result.authentications.collect{ |a| a.authentication.uid }.should == ["5930881311","1000038776937901","19125491"]
    end
  end

  context "viewing a single user's specific authentication" do
    use_vcr_cassette
    let(:result) { @client.user_authentication(7835, 19479) }

    it "should make a single authentication available" do
      result.authentication.provider.should == "twitter"
      result.authentication.uid.should == "5930881311"
      result.authentication.nickname.should == "demo"
    end
  end

  context "creating an authentication" do
    context "with valid parameters" do
      use_vcr_cassette
      let(:result) { @client.create_user_authentication(7887,
                                                        :provider    => "foursquare",
                                                        :uid         => "1234",
                                                        :oauth_token => "111",
                                                        :nickname    => "foursquare_name") }

      it "should return the new authentication's information" do
        result.authentication.provider.should == "foursquare"
        result.authentication.uid.should == "1234"
        result.authentication.nickname.should == "foursquare_name"
      end
    end

    context "with invalid parameters" do
      use_vcr_cassette

      it "should return an error 400" do
        expect do
          @client.create_user_authentication(7887)
        end.to raise_error(Checkdin::APIError, /400/)
      end
    end
  end

  context "viewing a list of blacklisted users" do
    use_vcr_cassette
    let(:result) { @client.blacklisted(:limit => 2) }

    it "should make a list of blacklisted users" do
      user_usernames = result.users.collect{|u| u.user.username}
      user_usernames.should == ["timothy.sanders.39948"]
    end

    it "should only return the right number of results" do
      result.users.count.should == 1
    end

  end

  context "blacklisting a user" do
    use_vcr_cassette
    let(:result) { @client.blacklist(8198) }

    it "should return user's basic information" do
      result.user.should_not be_nil
    end

    it "should return user with activity_state of blacklisted" do
      result.user.activity_state.should == 'blacklisted'
    end
  end

  context "whitelisting a user" do
    use_vcr_cassette
    let(:result) { @client.whitelist(8198) }

    it "should return user with activity_state of fresh" do
      result.user.activity_state.should == 'fresh'
    end
  end

  context "blacklisting a non-existing user" do
    use_vcr_cassette

    it "should throw an error" do
      expect do
          @client.blacklist(0)
      end.to raise_error(Checkdin::APIError, /404/)
    end
  end

  context "creating a point redemption" do
    context "with valid parameters" do
      use_vcr_cassette
      let(:result) { @client.create_user_point_redemption(961,
                                                          :point_value => 1000,
                                                          :rand_param  => "something-here") }

      it "should return success" do
        result.result.should == "success"
      end
    end

    context "with invalid parameters" do
      use_vcr_cassette

      it "should return an error 400" do
        expect do
          @client.create_user_point_redemption(961)
        end.to raise_error(Checkdin::APIError, /400/)
      end
    end
  end

  context "view user's full description" do
    use_vcr_cassette

    let(:result) { @client.view_user_full_description(8198) }
    it "should return an user object" do
      result.should_not be_blank?
    end
    it "should have authentications" do
      result.user.authentications.count.should_not == 0
    end
  end
end


