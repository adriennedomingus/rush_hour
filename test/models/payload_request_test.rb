require_relative '../test_helper'

class PayloadRequestTest < MiniTest::Test
  include TestHelpers

  def test_has_all_attributes_with_valid_input
    payload = {
      url:           Url.create(path: "http://jumpstartlab.com/blog"),
      requested_at:  "2013-02-16 21:38:28 -0700",
      responded_in:  37,
      referral:   Referral.create(path: "http://jumpstartlab.com"),
      request_type:  RequestType.create(verb: "GET"),
      event_name:    EventName.create(event: "socialLogin"),
      environment:    Environment.create(os: "OS X 10.5.3", browser: "Chrome"),
      resolution:    Resolution.create(width: "1080", height: "9000"),
      ip: Ip.create(address: "63.29.38.211")}

    payload_request = PayloadRequest.create(payload)

    assert_equal 1, PayloadRequest.all.count
    assert_equal "http://jumpstartlab.com/blog", payload_request.url.path
    assert_equal "2013-02-16 21:38:28 -0700", payload_request.requested_at
    assert_equal 37, payload_request.responded_in
    assert_equal "http://jumpstartlab.com", payload_request.referral.path
    assert_equal "GET", payload_request.request_type.verb
    assert_equal "socialLogin", payload_request.event_name.event
    assert_equal "OS X 10.5.3", payload_request.environment.os
    assert_equal "Chrome", payload_request.environment.browser
    assert_equal "63.29.38.211", payload_request.ip.address
  end

  def test_parsed_payload_has_all_attributes
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

    parsed_data = PayloadParser.new(payload).payload_hash

    payload_request = PayloadRequest.create(parsed_data)

    assert_equal 1, PayloadRequest.all.count
    assert_equal "http://jumpstartlab.com/blog", payload_request.url.path
    assert_equal "2013-02-16 21:38:28 -0700", payload_request.requested_at
    assert_equal 37, payload_request.responded_in
    assert_equal "http://jumpstartlab.com", payload_request.referral.path
    assert_equal "GET", payload_request.request_type.verb
    assert_equal "socialLogin", payload_request.event_name.event
    assert_equal "OS X 10.8.2", payload_request.environment.os
    assert_equal "Chrome", payload_request.environment.browser
    assert_equal "63.29.38.211", payload_request.ip.address
  end

  def test_validation_works_with_missing_attribute
    payload = {
      url:           Url.create(path: "http://jumpstartlab.com/blog"),
      requested_at:  "2013-02-16 21:38:28 -0700",
      responded_in:  37,
      request_type:  RequestType.create(verb: "GET"),
      event_name:    EventName.create(event: "socialLogin"),
      environment:   Environment.create(os: "OS X 10.5.3", browser: "Chrome"),
      resolution:    Resolution.create(width: "1080", height: "9000"),
      ip: Ip.create(address: "63.29.38.211")}

    PayloadRequest.create(payload)

    assert_equal 0, PayloadRequest.all.count
  end
end
