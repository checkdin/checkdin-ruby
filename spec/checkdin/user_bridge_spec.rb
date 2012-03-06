require 'spec_helper'
require 'timecop'

describe Checkdin::UserBridge, '#login_url' do
  let(:instance) { Checkdin::UserBridge.new(client_identifier, bridge_secret) }
  subject { instance.login_url(user_email, user_identifier, authentication_action) }
  let(:client_identifier) { 'client-1704' }
  let(:bridge_secret) { '123-shared-secret' }
  let(:user_email) { 'bob@example.com' }
  let(:user_identifier) { '17-batch1-bob' }
  let(:authentication_action) { nil }
  let(:timestamp) { 1325605589 }

  context "no custom domain set" do
    it "should output a url for app.checkd.in using https" do
      subject.should =~ /^https:\/\/app\.checkd\.in/
    end

    it "should include the correct timestamp" do
      Timecop.freeze(Time.at(timestamp)) do
        subject.should include('auth_timestamp=1325605589')
      end
    end

    it "returns a fully usable result" do
      Timecop.freeze(Time.at(timestamp)) do
        subject.should == "https://app.checkd.in/user_landing?auth_timestamp=1325605589&client_id=client-1704&client_uid=17-batch1-bob&digest=2ca9aca03aa115495e7ce50c941e0efce6e8aeb11480cde04fd1b03110c174ff&email=bob%40example.com"
      end
    end

    context "with an optional action set" do
      let(:authentication_action) { 'authenticate_facebook' }

      it "includes the authentication_action" do
        Timecop.freeze(Time.at(timestamp)) do
          subject.should == "https://app.checkd.in/user_landing?auth_timestamp=1325605589&authentication_action=authenticate_facebook&client_id=client-1704&client_uid=17-batch1-bob&digest=f27f0b46e8fb383f53e48d02da51be05f573d4aa80d727acfe08d2cc76db2861&email=bob%40example.com"
        end
      end
    end
  end

  it "uses custom subdomain" do
    instance.checkdin_landing_url = 'https://grace.checkd.in/user_landing?'
    Timecop.freeze(Time.at(timestamp)) do
      subject.should == "https://grace.checkd.in/user_landing?auth_timestamp=1325605589&client_id=client-1704&client_uid=17-batch1-bob&digest=2ca9aca03aa115495e7ce50c941e0efce6e8aeb11480cde04fd1b03110c174ff&email=bob%40example.com"
    end
  end

  it "uses custom domain" do
    instance.checkdin_landing_url = 'http://checkin.example.com/my_landing?'
    Timecop.freeze(Time.at(timestamp)) do
      subject.should == "http://checkin.example.com/my_landing?auth_timestamp=1325605589&client_id=client-1704&client_uid=17-batch1-bob&digest=2ca9aca03aa115495e7ce50c941e0efce6e8aeb11480cde04fd1b03110c174ff&email=bob%40example.com"
    end
  end
end

describe Checkdin::UserBridge, '#build_authenticated_parameters' do
  let(:instance) { Checkdin::UserBridge.new(client_identifier, bridge_secret) }
  subject { instance.build_authenticated_parameters(user_email, user_identifier) }
  let(:client_identifier) { 'client-1704' }
  let(:bridge_secret) { '123-shared-secret' }
  let(:user_email) { 'bob@example.com' }
  let(:user_identifier) { '17-batch1-bob' }
  let(:timestamp) { 1325605589 }

  it "should output a hash with timestamp and digest included" do
    Timecop.freeze(Time.at(timestamp)) do
      subject.should == {
        'auth_timestamp' => timestamp,
        'client_id'      => client_identifier,
        'client_uid'     => user_identifier,
        'email'          => user_email,
        'digest'         => '2ca9aca03aa115495e7ce50c941e0efce6e8aeb11480cde04fd1b03110c174ff'
      }
    end
  end

  context "with an authenticated action" do
    subject { instance.build_authenticated_parameters(user_email, user_identifier, authentication_action) }
    let(:authentication_action) { 'authenticate_facebook' }

    it "should output a hash with a different digest and the authenticated_action included" do
      Timecop.freeze(Time.at(timestamp)) do
        subject.should == {
          'auth_timestamp'        => timestamp,
          'authentication_action' => authentication_action,
          'client_id'             => client_identifier,
          'client_uid'            => user_identifier,
          'email'                 => user_email,
          'digest'                => 'f27f0b46e8fb383f53e48d02da51be05f573d4aa80d727acfe08d2cc76db2861'
        }
      end
    end
  end

end
