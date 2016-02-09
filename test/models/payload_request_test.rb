require_relative '../test_helper'

class PayloadRequestTest < MiniTest::Test
  include TestHelpers

  def test_has_all_attributes_with_valid_input
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
    }

    payload_request = PayloadRequest.create(requestd_at: payload[:requestedAt], responded_in: payload[:respondedIn], parameters: payload[:parameters], event_name: [payload[:parameters]])
    payload_request.url.create(url_name: payload["url"])
    assert_equal 1, PayloadRequest.all.count
    assert_equal "socialLogin", PayloadRequest.first.eventName
    assert_equal "http://jumpstartlab.com/blog", PayloadRequest.first.url.url_name
  end
end
