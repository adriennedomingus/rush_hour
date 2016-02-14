require_relative '../test_helper'
require 'json'

class DeleteClientTest < Minitest::Test
  include Rack::Test::Methods
  include TestHelpers

  def app
    RushHour::Server
  end

  def payload_one
      { url:           Url.find_or_create_by(path: "http://jumpstartlab.com/blog"),
        requested_at:  "2013-02-16 01:38:28 -0700",
        responded_in:  30,
        referral:   Referral.find_or_create_by(path: "http://jumpstartlab.com"),
        request_type:  RequestType.find_or_create_by(verb: "GET"),
        event_name:    EventName.find_or_create_by(event: "socialLogin"),
        environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Chrome"),
        resolution:    Resolution.find_or_create_by(width: "1920", height: "1280"),
        ip: Ip.find_or_create_by(address: "63.29.38.211"),
        client: Client.find_by(identifier: "jumpstartlab")}
  end

  def test_client_can_delete_their_account_and_data
    post '/sources', {"identifier"=>"jumpstartlab", "rootUrl"=>"http://jumpstartlab.com"}
    post '/sources', {"identifier"=>"testlab", "rootUrl"=>"http://testlab.com"}

    PayloadRequest.create(payload_one)

    assert_equal 2, Client.count
    assert_equal 1, PayloadRequest.count
    # assert_equal 1, Url.count
    delete '/jumpstartlab/delete'

    assert_equal 1, Client.count
    assert_equal 0, PayloadRequest.count
    # assert_equal 0, Url.count
  end
end
