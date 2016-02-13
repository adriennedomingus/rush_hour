module TestPayloads
  def payload_one
    { url:           Url.find_or_create_by(path: "http://jumpstartlab.com/blog"),
      requested_at:  "2013-02-16 01:38:28 -0700",
      responded_in:  30,
      referral:   Referral.find_or_create_by(path: "http://jumpstartlab.com"),
      request_type:  RequestType.find_or_create_by(verb: "GET"),
      event_name:    EventName.find_or_create_by(event: "anotherEvent"),
      environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Chrome"),
      resolution:    Resolution.find_or_create_by(width: "1920", height: "1280"),
      ip: Ip.find_or_create_by(address: "63.29.38.211"),
      client: Client.find_by(identifier: "jumpstartlab")}
  end

  def payload_two
    { url:           Url.find_or_create_by(path: "http://jumpstartlab.com/about"),
      requested_at:  "2013-02-16 01:38:28 -0700",
      responded_in:  60,
      referral:   Referral.find_or_create_by(path: "http://jumpstartlab.com"),
      request_type:  RequestType.find_or_create_by(verb: "GET"),
      event_name:    EventName.find_or_create_by(event: "socialLogin"),
      environment:    Environment.find_or_create_by(os: "OS X 10.6.3", browser: "Chrome"),
      resolution:    Resolution.find_or_create_by(width: "1920", height: "1280"),
      ip: Ip.find_or_create_by(address: "63.29.38.211"),
      client: Client.find_by(identifier: "jumpstartlab")}
  end

  def payload_three
    { url:           Url.find_or_create_by(path: "http://jumpstartlab.com/blog"),
      requested_at:  "2013-02-16 21:38:28 -0700",
      responded_in:  45,
      referral:   Referral.find_or_create_by(path: "http://jumpstartlab.com"),
      request_type:  RequestType.find_or_create_by(verb: "POST"),
      event_name:    EventName.find_or_create_by(event: "yetAnother"),
      environment:    Environment.find_or_create_by(os: "OS X 10.6.3", browser: "Safari"),
      resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
      ip: Ip.find_or_create_by(address: "63.29.38.211"),
      client: Client.find_by(identifier: "jumpstartlab")}
  end

  def payload_four
    {url:           Url.find_or_create_by(path: "http://testlab.com/test"),
    requested_at:  "2013-02-16 21:38:28 -0700",
    responded_in:  37,
    referral:   Referral.find_or_create_by(path: "http://google.com"),
    request_type:  RequestType.find_or_create_by(verb: "PUT"),
    event_name:    EventName.find_or_create_by(event: "socialLogin"),
    environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Chrome"),
    resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
    ip: Ip.find_or_create_by(address: "63.29.38.211"),
    client: Client.find_by(identifier: "testlab")}
  end

  def payload_five
    {url:           Url.find_or_create_by(path: "http://testlab.com/test"),
    requested_at:  "2013-02-16 20:00:00 -0700",
    responded_in:  30,
    referral:   Referral.find_or_create_by(path: "http://google.com"),
    request_type:  RequestType.find_or_create_by(verb: "POST"),
    event_name:    EventName.find_or_create_by(event: "socialLogin"),
    environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Chrome"),
    resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
    ip: Ip.find_or_create_by(address: "63.29.38.211"),
    client: Client.find_by(identifier: "testlab")}
  end

  def payload_six
    {url:           Url.find_or_create_by(path: "http://testlab.com/test"),
    requested_at:  "2013-02-16 20:00:00 -0700",
    responded_in:  33,
    referral:   Referral.find_or_create_by(path: "http://testlab.com/blog"),
    request_type:  RequestType.find_or_create_by(verb: "POST"),
    event_name:    EventName.find_or_create_by(event: "socialLogin"),
    environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Safari"),
    resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
    ip: Ip.find_or_create_by(address: "63.29.38.211"),
    client: Client.find_by(identifier: "testlab")}
  end

  def payload_seven
    {url:           Url.find_or_create_by(path: "http://testlab.com/test"),
    requested_at:  "2013-02-16 20:00:00 -0700",
    responded_in:  35,
    referral:   Referral.find_or_create_by(path: "http://testlab.com"),
    request_type:  RequestType.find_or_create_by(verb: "GET"),
    event_name:    EventName.find_or_create_by(event: "socialLogin"),
    environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Firefox"),
    resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
    ip: Ip.find_or_create_by(address: "63.29.38.211"),
    client: Client.find_by(identifier: "testlab")}
  end

  def payload_eight
    {url:           Url.find_or_create_by(path: "http://testlab.com/test"),
    requested_at:  "2013-02-16 20:00:00 -0700",
    responded_in:  37,
    referral:   Referral.find_or_create_by(path: "http://testlab.com"),
    request_type:  RequestType.find_or_create_by(verb: "GET"),
    event_name:    EventName.find_or_create_by(event: "socialLogin"),
    environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Chrome"),
    resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
    ip: Ip.find_or_create_by(address: "63.29.38.211"),
    client: Client.find_by(identifier: "testlab")}
  end

  def payload_nine
    {url:           Url.find_or_create_by(path: "http://testlab.com/test"),
    requested_at:  "2013-02-16 20:00:00 -0700",
    responded_in:  30,
    referral:   Referral.find_or_create_by(path: "http://testlab.com"),
    request_type:  RequestType.find_or_create_by(verb: "GET"),
    event_name:    EventName.find_or_create_by(event: "socialLogin"),
    environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Chrome"),
    resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
    ip: Ip.find_or_create_by(address: "63.29.38.211"),
    client: Client.find_by(identifier: "testlab")}
  end
end
