require_relative '../test_helper'

class UrlTest < MiniTest::Test
  include TestHelpers

  def payload1
    {url:           Url.find_or_create_by(path: "http://jumpstartlab.com/blog"),
    requested_at:  "2013-02-16 21:38:28 -0700",
    responded_in:  37,
    referral:   Referral.find_or_create_by(path: "http://jumpstartlab.com"),
    request_type:  RequestType.find_or_create_by(verb: "GET"),
    event_name:    EventName.find_or_create_by(event: "socialLogin"),
    environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Chrome"),
    resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
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
    resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
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

  def payload4
    {url:           Url.find_or_create_by(path: "http://jumpstartlab.com"),
    requested_at:  "2013-02-16 20:00:00 -0700",
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
    requested_at:  "2013-02-16 20:00:00 -0700",
    responded_in:  30,
    referral:   Referral.find_or_create_by(path: "http://jumpstartlab.com/contact"),
    request_type:  RequestType.find_or_create_by(verb: "POST"),
    event_name:    EventName.find_or_create_by(event: "socialLogin"),
    environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Firefox"),
    resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
    ip: Ip.find_or_create_by(address: "63.29.38.211")}
  end

  def payload6
    {url:           Url.find_or_create_by(path: "http://jumpstartlab.com/about"),
    requested_at:  "2013-02-16 20:00:00 -0700",
    responded_in:  30,
    referral:   Referral.find_or_create_by(path: "http://jumpstartlab.com/home"),
    request_type:  RequestType.find_or_create_by(verb: "POST"),
    event_name:    EventName.find_or_create_by(event: "socialLogin"),
    environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Chrome"),
    resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
    ip: Ip.find_or_create_by(address: "63.29.38.211")}
  end


  def test_max_response_time
    PayloadRequest.create(payload1)
    PayloadRequest.create(payload2)
    url = Url.find(1)

    assert_equal 37, url.max_response_time
  end

  def test_min_response_time
    PayloadRequest.create(payload1)
    PayloadRequest.create(payload2)
    url = Url.find(1)

    assert_equal 30, url.min_response_time
  end

  def test_response_time_list_longest_to_shortest
    PayloadRequest.create(payload1)
    PayloadRequest.create(payload2)
    url = Url.find(1)

    assert_equal [37, 30], url.response_times
  end

  def test_avg_response_time
    PayloadRequest.create(payload1)
    PayloadRequest.create(payload2)
    url = Url.find(1)

    assert_equal 33.5, url.avg_response_time
  end

  def test_verbs
    PayloadRequest.create(payload1)
    PayloadRequest.create(payload2)
    url = Url.find(1)

    assert_equal ['GET', 'POST'], url.verbs
  end

  def test_top_referers
    PayloadRequest.create(payload1)
    PayloadRequest.create(payload2)
    PayloadRequest.create(payload3)
    PayloadRequest.create(payload4)
    PayloadRequest.create(payload5)
    PayloadRequest.create(payload6)

    url = Url.find(1)

    assert_equal 3, url.top_referrers.count
    assert_equal ["http://jumpstartlab.com/contact", "http://jumpstartlab.com/home",
      "http://jumpstartlab.com"], url.top_referrers
  end

<<<<<<< HEAD
  def top_user_agents
=======
  def test_top_user_agents
>>>>>>> july_weds
    PayloadRequest.create(payload1)
    PayloadRequest.create(payload2)
    PayloadRequest.create(payload3)
    PayloadRequest.create(payload4)
    PayloadRequest.create(payload5)
    PayloadRequest.create(payload6)

    url = Url.find(1)

    assert_equal 3, url.top_user_agents.count
    assert_equal ["Chrome, OS X 10.5.3", "Firefox, OS X 10.5.3", "Safari, OS X 10.5.3"], url.top_user_agents
  end

  def test_top_urls_in_order
    PayloadRequest.create(payload1)
    PayloadRequest.create(payload2)
    PayloadRequest.create(payload3)
    PayloadRequest.create(payload4)
    PayloadRequest.create(payload5)
    PayloadRequest.create(payload6)

    result = ["http://jumpstartlab.com/blog", "http://jumpstartlab.com/about", "http://jumpstartlab.com"]

    assert_equal result, Url.in_order
  end

end
