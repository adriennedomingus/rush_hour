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

  def test_validation_works_with_missing_attribute
    payload = {
      url:           Url.create(path: "http://jumpstartlab.com/blog"),
      requested_at:  "2013-02-16 21:38:28 -0700",
      responded_in:  37,
      request_type:  RequestType.create(verb: "GET"),
      event_name:    EventName.create(event: "socialLogin"),
      environment:    Environment.create(os: "OS X 10.5.3", browser: "Chrome"),
      resolution:    Resolution.create(width: "1080", height: "9000"),
      ip: Ip.create(address: "63.29.38.211")}

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
      environment:    Environment.create(os: "OS X 10.5.3", browser: "Chrome"),
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

      payload3 = {
        url:           Url.create(path: "http://jumpstartlab.com/blog"),
        requested_at:  "2013-02-16 21:38:28 -0700",
        responded_in:  15,
        referral:   Referral.create(path: "http://jumpstartlab.com"),
        request_type:  RequestType.create(verb: "GET"),
        event_name:    EventName.create(event: "socialLogin"),
        environment:    Environment.create(os: "OS X 10.5.3", browser: "Chrome"),
        resolution:    Resolution.create(width: "1080", height: "9000"),
        ip: Ip.create(address: "63.29.38.211")}

      PayloadRequest.create(payload)
      PayloadRequest.create(payload2)
      PayloadRequest.create(payload3)

      assert_equal "GET", PayloadRequest.most_frequent_request_type
  end

  def test_all_http_verbs
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

      payload3 = {
        url:           Url.create(path: "http://jumpstartlab.com/blog"),
        requested_at:  "2013-02-16 21:38:28 -0700",
        responded_in:  15,
        referral:   Referral.create(path: "http://jumpstartlab.com"),
        request_type:  RequestType.create(verb: "PUT"),
        event_name:    EventName.create(event: "socialLogin"),
        environment:    Environment.create(os: "OS X 10.5.3", browser: "Chrome"),
        resolution:    Resolution.create(width: "1080", height: "9000"),
        ip: Ip.create(address: "63.29.38.211")}

      PayloadRequest.create(payload)
      PayloadRequest.create(payload2)
      PayloadRequest.create(payload3)

      assert_equal ["GET", "POST", "PUT"], PayloadRequest.all_http_verbs
  end
end