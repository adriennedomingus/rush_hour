require_relative '../test_helper'

class PayloadParserTest < MiniTest::Test
  include TestHelpers

  def test_payload_parser_parses
    payload = {
    "url":"http://jumpstartlab.com/blog",
    "requestedAt":"2013-02-16 21:38:28 -0700",
    "respondedIn":37,
    "referredBy":"http://jumpstartlab.com",
    "requestType":"GET",
    "parameters":[],
    "eventName": "socialLogin",
    "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
    "resolutionWidth":"1920",
    "resolutionHeight":"1280",
    "ip":"63.29.38.211"
    }.to_json

    parsed_data = PayloadParser.new(payload)

    assert parsed_data.instance_of?(PayloadParser)

    payload_hash = parsed_data.payload_hash

    assert_equal Hash, payload_hash.class
    assert_equal Url, payload_hash[:url].class
    assert_equal "http://jumpstartlab.com/blog", payload_hash[:url].path
    assert_equal "2013-02-16 21:38:28 -0700", payload_hash[:requested_at]
    assert_equal 37, payload_hash[:responded_in]
    assert_equal Referral, payload_hash[:referral].class
    assert_equal "http://jumpstartlab.com", payload_hash[:referral].path
    assert_equal RequestType, payload_hash[:request_type].class
    assert_equal "GET", payload_hash[:request_type].verb
    assert_equal nil, payload_hash[:parameters]
    assert_equal EventName, payload_hash[:event_name].class
    assert_equal "socialLogin", payload_hash[:event_name].event
    assert_equal "OS X 10.8.2", payload_hash[:environment].os
    assert_equal "Chrome", payload_hash[:environment].browser
    assert_equal Resolution, payload_hash[:resolution].class
    assert_equal "1920", payload_hash[:resolution].width
    assert_equal "1280", payload_hash[:resolution].height
    assert_equal Ip, payload_hash[:ip].class
    assert_equal "63.29.38.211", payload_hash[:ip].address
  end
end
