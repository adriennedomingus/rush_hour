require_relative '../test_helper'
require_relative '../test_payloads'

class PayloadRequestTest < MiniTest::Test
  include TestHelpers
  include TestPayloads

  def test_has_all_attributes_with_valid_input
    create_client

    payload_request = PayloadRequest.create(payload1)

    assert_equal 1, PayloadRequest.all.count
    assert_equal "http://jumpstartlab.com/blog", payload_request.url.path
    assert_equal "2013-02-16 01:38:28 -0700", payload_request.requested_at
    assert_equal 30, payload_request.responded_in
    assert_equal "http://jumpstartlab.com", payload_request.referral.path
    assert_equal "GET", payload_request.request_type.verb
    assert_equal "anotherEvent", payload_request.event_name.event
    assert_equal "OS X 10.5.3", payload_request.environment.os
    assert_equal "Chrome", payload_request.environment.browser
    assert_equal "63.29.38.211", payload_request.ip.address
    assert_equal "1920", payload_request.resolution.width
    assert_equal "1280", payload_request.resolution.height
    assert_equal 1, payload_request.client_id
    assert_equal "jumpstartlab", payload_request.client.identifier
  end

  def test_parsed_payload_has_all_attributes
    create_client

    parsed_data = PayloadParser.new(unparsed_payload, "jumpstartlab").payload_hash

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
    create_client

    PayloadRequest.create(payload_missing_attribute)

    assert_equal 0, PayloadRequest.all.count
  end

  def test_multiple_payload_creations
    create_client
    create_15_payloads

    assert_equal 15, PayloadRequest.all.count
  end

  def test_average_response_time
    create_client
    create_15_payloads

    assert_equal 33, PayloadRequest.average_response_time.to_i
  end

  def test_maximum_response_time
    create_client
    create_15_payloads

    assert_equal 60, PayloadRequest.maximum_response_time
  end

  def test_minimum_response_time
    create_client
    create_15_payloads

    assert_equal 15, PayloadRequest.minimum_response_time
  end
end
