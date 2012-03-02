require 'spec_helper'
require 'timecop'

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
