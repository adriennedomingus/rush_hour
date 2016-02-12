require_relative '../test_helper'

class EventNameTest < MiniTest::Test
  include TestHelpers

  def payload1
    {url:           Url.find_or_create_by(path: "http://jumpstartlab.com/blog"),
    requested_at:  "2013-02-16 21:38:28 -0700",
    responded_in:  37,
    referral:   Referral.find_or_create_by(path: "http://jumpstartlab.com"),
    request_type:  RequestType.find_or_create_by(verb: "GET"),
    event_name:    EventName.find_or_create_by(event: "anotherEvent"),
    environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Chrome"),
    resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
    ip: Ip.find_or_create_by(address: "63.29.38.211")}
  end

  def payload2
    {url:           Url.find_or_create_by(path: "http://jumpstartlab.com/blog"),
    requested_at:  "2013-02-16 09:00:00 -0700",
    responded_in:  30,
    referral:   Referral.find_or_create_by(path: "http://jumpstartlab.com/home"),
    request_type:  RequestType.find_or_create_by(verb: "POST"),
    event_name:    EventName.find_or_create_by(event: "socialLogin"),
    environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Chrome"),
    resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
    ip: Ip.find_or_create_by(address: "63.29.38.211")}
  end

  def payload3
    {url:           Url.find_or_create_by(path: "http://jumpstartlab.com/blog"),
    requested_at:  "2013-02-16 14:00:00 -0700",
    responded_in:  30,
    referral:   Referral.find_or_create_by(path: "http://jumpstartlab.com/contact"),
    request_type:  RequestType.find_or_create_by(verb: "POST"),
    event_name:    EventName.find_or_create_by(event: "socialLogin"),
    environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Safari"),
    resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
    ip: Ip.find_or_create_by(address: "63.29.38.211")}
  end

  def payload4
    {url:           Url.find_or_create_by(path: "http://jumpstartlab.com"),
    requested_at:  "2013-02-16 18:00:00 -0700",
    responded_in:  30,
    referral:   Referral.find_or_create_by(path: "http://jumpstartlab.com/contact"),
    request_type:  RequestType.find_or_create_by(verb: "POST"),
    event_name:    EventName.find_or_create_by(event: "socialLogin"),
    environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Firefox"),
    resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
    ip: Ip.find_or_create_by(address: "63.29.38.211")}
  end

  def payload5
    {url:           Url.find_or_create_by(path: "http://jumpstartlab.com/about"),
    requested_at:  "2013-02-16 12:00:00 -0700",
    responded_in:  30,
    referral:   Referral.find_or_create_by(path: "http://jumpstartlab.com/contact"),
    request_type:  RequestType.find_or_create_by(verb: "POST"),
    event_name:    EventName.find_or_create_by(event: "anotherEvent"),
    environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Chrome"),
    resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
    ip: Ip.find_or_create_by(address: "63.29.38.211")}
  end

  def payload6
    {url:           Url.find_or_create_by(path: "http://jumpstartlab.com/about"),
    requested_at:  "2013-02-16 10:00:00 -0700",
    responded_in:  30,
    referral:   Referral.find_or_create_by(path: "http://jumpstartlab.com/home"),
    request_type:  RequestType.find_or_create_by(verb: "POST"),
    event_name:    EventName.find_or_create_by(event: "yetAnother"),
    environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Chrome"),
    resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
    ip: Ip.find_or_create_by(address: "63.29.38.211")}
  end

  def test_top_events
    PayloadRequest.create(payload1)
    PayloadRequest.create(payload2)
    PayloadRequest.create(payload3)
    PayloadRequest.create(payload4)
    PayloadRequest.create(payload5)
    PayloadRequest.create(payload6)

    result = ["socialLogin", "anotherEvent", "yetAnother"]

    assert_equal result, EventName.in_order
  end

  def test_events_by_hour
    PayloadRequest.create(payload1)
    PayloadRequest.create(payload2)
    PayloadRequest.create(payload3)
    PayloadRequest.create(payload4)
    PayloadRequest.create(payload5)
    PayloadRequest.create(payload6)

    result = { 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0, 7 => 0, 8 => 0,
      9 => 1, 10 => 1, 11 => 0, 12 => 1, 13 => 0, 14 => 1, 15 => 0, 16 => 0,
      17 => 0, 18 => 1, 19 => 0, 20 => 0, 21 => 1, 22 => 0, 23 => 0, 24 => 0}

    assert_equal result, EventName.find_by(:event => "socialLogin").by_hour

  end
end
