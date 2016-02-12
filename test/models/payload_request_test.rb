require_relative '../test_helper'

class PayloadRequestTest < MiniTest::Test
  include TestHelpers

  def test_has_all_attributes_with_valid_input

    Client.create("identifier"=>"jumpstartlab", "root_url"=>"http://jumpstartlab.com")
    payload = {
      url:           Url.find_or_create_by(path: "http://jumpstartlab.com/blog"),
      requested_at:  "2013-02-16 21:38:28 -0700",
      responded_in:  37,
      referral:   Referral.find_or_create_by(path: "http://jumpstartlab.com"),
      request_type:  RequestType.find_or_create_by(verb: "GET"),
      event_name:    EventName.find_or_create_by(event: "socialLogin"),
      environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Chrome"),
      resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
      ip: Ip.find_or_create_by(address: "63.29.38.211"),
      client: Client.find_by(identifier: "jumpstartlab")}

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
    assert_equal "1080", payload_request.resolution.width
    assert_equal "9000", payload_request.resolution.height
    assert_equal 1, payload_request.client_id
    assert_equal "jumpstartlab", payload_request.client.identifier
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

    parsed_data = PayloadParser.new(payload, "don't fail").payload_hash

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
      url:           Url.find_or_create_by(path: "http://jumpstartlab.com/blog"),
      requested_at:  "2013-02-16 21:38:28 -0700",
      responded_in:  37,
      request_type:  RequestType.find_or_create_by(verb: "GET"),
      event_name:    EventName.find_or_create_by(event: "socialLogin"),
      environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Chrome"),
      resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
      ip: Ip.find_or_create_by(address: "63.29.38.211")}

    PayloadRequest.create(payload)

    assert_equal 0, PayloadRequest.all.count
  end

  def test_multiple_payload_creations
    payload = {
      url:           Url.create(path: "http://jumpstartlab.com/blog"),
      requested_at:  "2013-02-16 21:38:28 -0700",
      responded_in:  37,
      referral:   Referral.create(path: "http://jumpstartlab.com"),
      request_type:  RequestType.create(verb: "GET"),
      event_name:    EventName.create(event: "socialLogin"),
      environment:   Environment.create(os: "OS X 10.5.3", browser: "Chrome"),
      resolution:    Resolution.create(width: "1080", height: "9000"),
      ip: Ip.create(address: "63.29.38.211")}

    payload2 = {
      url:           Url.create(path: "http://jumpstartlab.com/blog"),
      requested_at:  "2013-02-16 21:38:28 -0700",
      responded_in:  37,
      referral:   Referral.create(path: "http://jumpstartlab.com"),
      request_type:  RequestType.create(verb: "POST"),
      event_name:    EventName.create(event: "socialLogin"),
      environment:    Environment.create(os: "OS X 10.5.3", browser: "Chrome"),
      resolution:    Resolution.create(width: "1080", height: "9000"),
      ip: Ip.create(address: "63.29.38.211")}

      PayloadRequest.create(payload)
      PayloadRequest.create(payload2)

      assert_equal 2, PayloadRequest.all.count
  end

  def test_average_response_time
    payload = {
      url:           Url.create(path: "http://jumpstartlab.com/blog"),
      requested_at:  "2013-02-16 21:38:28 -0700",
      responded_in:  45,
      referral:   Referral.create(path: "http://jumpstartlab.com"),
      request_type:  RequestType.create(verb: "GET"),
      event_name:    EventName.create(event: "socialLogin"),
      environment:    Environment.create(os: "OS X 10.5.3", browser: "Chrome"),
      resolution:    Resolution.create(width: "1080", height: "9000"),
      ip: Ip.create(address: "63.29.38.211")}

    payload2 = {
      url:           Url.create(path: "http://jumpstartlab.com/blog"),
      requested_at:  "2013-02-16 21:38:28 -0700",
      responded_in:  15,
      referral:   Referral.create(path: "http://jumpstartlab.com"),
      request_type:  RequestType.create(verb: "POST"),
      event_name:    EventName.create(event: "socialLogin"),
      environment:    Environment.create(os: "OS X 10.5.3", browser: "Chrome"),
      resolution:    Resolution.create(width: "1080", height: "9000"),
      ip: Ip.create(address: "63.29.38.211")}

      PayloadRequest.create(payload)
      PayloadRequest.create(payload2)

      assert_equal 30, PayloadRequest.average_response_time
  end

  def test_maximum_response_time
    payload = {
      url:           Url.create(path: "http://jumpstartlab.com/blog"),
      requested_at:  "2013-02-16 21:38:28 -0700",
      responded_in:  45,
      referral:   Referral.create(path: "http://jumpstartlab.com"),
      request_type:  RequestType.create(verb: "GET"),
      event_name:    EventName.create(event: "socialLogin"),
      environment:    Environment.create(os: "OS X 10.5.3", browser: "Chrome"),
      resolution:    Resolution.create(width: "1080", height: "9000"),
      ip: Ip.create(address: "63.29.38.211")}

    payload2 = {
      url:           Url.create(path: "http://jumpstartlab.com/blog"),
      requested_at:  "2013-02-16 21:38:28 -0700",
      responded_in:  15,
      referral:   Referral.create(path: "http://jumpstartlab.com"),
      request_type:  RequestType.create(verb: "POST"),
      event_name:    EventName.create(event: "socialLogin"),
      environment:    Environment.create(os: "OS X 10.5.3", browser: "Chrome"),
      resolution:    Resolution.create(width: "1080", height: "9000"),
      ip: Ip.create(address: "63.29.38.211")}

      PayloadRequest.create(payload)
      PayloadRequest.create(payload2)

      assert_equal 45, PayloadRequest.maximum_response_time
  end

  def test_minimum_response_time
    payload = {
      url:           Url.create(path: "http://jumpstartlab.com/blog"),
      requested_at:  "2013-02-16 21:38:28 -0700",
      responded_in:  45,
      referral:   Referral.create(path: "http://jumpstartlab.com"),
      request_type:  RequestType.create(verb: "GET"),
      event_name:    EventName.create(event: "socialLogin"),
      environment:    Environment.create(os: "OS X 10.5.3", browser: "Chrome"),
      resolution:    Resolution.create(width: "1080", height: "9000"),
      ip: Ip.create(address: "63.29.38.211")}

    payload2 = {
      url:           Url.create(path: "http://jumpstartlab.com/blog"),
      requested_at:  "2013-02-16 21:38:28 -0700",
      responded_in:  15,
      referral:   Referral.create(path: "http://jumpstartlab.com"),
      request_type:  RequestType.create(verb: "POST"),
      event_name:    EventName.create(event: "socialLogin"),
      environment:    Environment.create(os: "OS X 10.5.3", browser: "Chrome"),
      resolution:    Resolution.create(width: "1080", height: "9000"),
      ip: Ip.create(address: "63.29.38.211")}

      PayloadRequest.create(payload)
      PayloadRequest.create(payload2)

      assert_equal 15, PayloadRequest.minimum_response_time
  end
end
