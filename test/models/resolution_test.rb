require_relative '../test_helper'

class ResolutionTest < MiniTest::Test
  include TestHelpers

  def payload1
    {url:           Url.find_or_create_by(path: "http://jumpstartlab.com/blog"),
    requested_at:  "2013-02-16 21:38:28 -0700",
    responded_in:  37,
    referral:   Referral.find_or_create_by(path: "http://jumpstartlab.com"),
    request_type:  RequestType.find_or_create_by(verb: "GET"),
    event_name:    EventName.find_or_create_by(event: "socialLogin"),
    environment:    Environment.find_or_create_by(os: "OS X 10.6.3", browser: "Safari"),
    resolution:    Resolution.find_or_create_by(width: "1136", height: "640"),
    ip: Ip.find_or_create_by(address: "63.29.38.211")}
  end

  def payload2
    {url:           Url.find_or_create_by(path: "http://jumpstartlab.com/blog"),
    requested_at:  "2013-02-16 20:00:00 -0700",
    responded_in:  30,
    referral:   Referral.find_or_create_by(path: "http://jumpstartlab.com/home"),
    request_type:  RequestType.find_or_create_by(verb: "POST"),
    event_name:    EventName.find_or_create_by(event: "socialLogin"),
    environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Chrome"),
    resolution:    Resolution.find_or_create_by(width: "1136", height: "640"),
    ip: Ip.find_or_create_by(address: "63.29.38.211")}
  end

  def payload3
    {url:           Url.find_or_create_by(path: "http://jumpstartlab.com/blog"),
    requested_at:  "2013-02-16 20:00:00 -0700",
    responded_in:  30,
    referral:   Referral.find_or_create_by(path: "http://jumpstartlab.com/contact"),
    request_type:  RequestType.find_or_create_by(verb: "POST"),
    event_name:    EventName.find_or_create_by(event: "socialLogin"),
    environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Safari"),
    resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
    ip: Ip.find_or_create_by(address: "63.29.38.211")}
  end

  def test_all_browsers_in_order
    PayloadRequest.create(payload1)
    PayloadRequest.create(payload2)
    PayloadRequest.create(payload3)

    result = ["1136 x 640", "1080 x 9000"]

    assert_equal result, Resolution.all_resolutions
  end
end
