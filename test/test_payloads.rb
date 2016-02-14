module TestPayloads

  def create_15_payloads
    PayloadRequest.create(payload1)
    PayloadRequest.create(payload2)
    PayloadRequest.create(payload3)
    PayloadRequest.create(payload4)
    PayloadRequest.create(payload5)
    PayloadRequest.create(payload6)
    PayloadRequest.create(payload7)
    PayloadRequest.create(payload8)
    PayloadRequest.create(payload9)
    PayloadRequest.create(payload10)
    PayloadRequest.create(payload11)
    PayloadRequest.create(payload12)
    PayloadRequest.create(payload13)
    PayloadRequest.create(payload14)
    PayloadRequest.create(payload15)
  end

  def payload1
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

  def payload2
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

  def payload3
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

  def payload4
    {url:           Url.find_or_create_by(path: "http://jumpstartlab.com/test"),
    requested_at:  "2013-02-16 21:38:28 -0700",
    responded_in:  37,
    referral:   Referral.find_or_create_by(path: "http://google.com"),
    request_type:  RequestType.find_or_create_by(verb: "PUT"),
    event_name:    EventName.find_or_create_by(event: "socialLogin"),
    environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Chrome"),
    resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
    ip: Ip.find_or_create_by(address: "63.29.38.211"),
    client: Client.find_by(identifier: "jumpstartlab")}
  end

  def payload5
    {url:           Url.find_or_create_by(path: "http://jumpstartlab.com/test"),
    requested_at:  "2013-02-16 20:00:00 -0700",
    responded_in:  30,
    referral:   Referral.find_or_create_by(path: "http://google.com"),
    request_type:  RequestType.find_or_create_by(verb: "POST"),
    event_name:    EventName.find_or_create_by(event: "socialLogin"),
    environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Chrome"),
    resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
    ip: Ip.find_or_create_by(address: "63.29.38.211"),
    client: Client.find_by(identifier: "jumpstartlab")}
  end

  def payload6
    {url:           Url.find_or_create_by(path: "http://jumpstartlab.com/test"),
    requested_at:  "2013-02-16 20:00:00 -0700",
    responded_in:  33,
    referral:   Referral.find_or_create_by(path: "http://jumpstartlab.com/blog"),
    request_type:  RequestType.find_or_create_by(verb: "POST"),
    event_name:    EventName.find_or_create_by(event: "socialLogin"),
    environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Safari"),
    resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
    ip: Ip.find_or_create_by(address: "63.29.38.211"),
    client: Client.find_by(identifier: "jumpstartlab")}
  end

  def payload7
    {url:           Url.find_or_create_by(path: "http://jumpstartlab.com/test"),
    requested_at:  "2013-02-16 10:00:00 -0700",
    responded_in:  35,
    referral:   Referral.find_or_create_by(path: "http://jumpstartlab.com"),
    request_type:  RequestType.find_or_create_by(verb: "GET"),
    event_name:    EventName.find_or_create_by(event: "socialLogin"),
    environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Firefox"),
    resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
    ip: Ip.find_or_create_by(address: "63.29.38.211"),
    client: Client.find_by(identifier: "jumpstartlab")}
  end

  def payload8
    {url:           Url.find_or_create_by(path: "http://jumpstartlab.com/test"),
    requested_at:  "2013-02-16 11:00:00 -0700",
    responded_in:  37,
    referral:   Referral.find_or_create_by(path: "http://jumpstartlab.com"),
    request_type:  RequestType.find_or_create_by(verb: "GET"),
    event_name:    EventName.find_or_create_by(event: "socialLogin"),
    environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Chrome"),
    resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
    ip: Ip.find_or_create_by(address: "63.29.38.211"),
    client: Client.find_by(identifier: "jumpstartlab")}
  end

  def payload9
    {url:           Url.find_or_create_by(path: "http://jumpstartlab.com/test"),
    requested_at:  "2013-02-16 12:00:00 -0700",
    responded_in:  30,
    referral:   Referral.find_or_create_by(path: "http://jumpstartlab.com"),
    request_type:  RequestType.find_or_create_by(verb: "GET"),
    event_name:    EventName.find_or_create_by(event: "socialLogin"),
    environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Chrome"),
    resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
    ip: Ip.find_or_create_by(address: "63.29.38.211"),
    client: Client.find_by(identifier: "jumpstartlab")}
  end

  def payload10
    {url:           Url.find_or_create_by(path: "http://jumpstartlab.com/blog"),
    requested_at:  "2013-02-16 13:38:28 -0700",
    responded_in:  37,
    referral:   Referral.find_or_create_by(path: "http://jumpstartlab.com"),
    request_type:  RequestType.find_or_create_by(verb: "GET"),
    event_name:    EventName.find_or_create_by(event: "socialLogin"),
    environment:    Environment.find_or_create_by(os: "OS X 10.6.3", browser: "Safari"),
    resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
    ip: Ip.find_or_create_by(address: "63.29.38.211"),
    client: Client.find_by(identifier: "jumpstartlab")}
  end

  def payload11
    {url:           Url.find_or_create_by(path: "http://jumpstartlab.com/blog"),
    requested_at:  "2013-02-16 14:00:00 -0700",
    responded_in:  30,
    referral:   Referral.find_or_create_by(path: "http://jumpstartlab.com/home"),
    request_type:  RequestType.find_or_create_by(verb: "POST"),
    event_name:    EventName.find_or_create_by(event: "socialLogin"),
    environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Chrome"),
    resolution:    Resolution.find_or_create_by(width: "4400", height: "8800"),
    ip: Ip.find_or_create_by(address: "63.29.38.211"),
    client: Client.find_by(identifier: "jumpstartlab")}
  end

  def payload12
    {url:           Url.find_or_create_by(path: "http://jumpstartlab.com/blog"),
    requested_at:  "2013-02-16 20:00:00 -0700",
    responded_in:  30,
    referral:   Referral.find_or_create_by(path: "http://jumpstartlab.com/contact"),
    request_type:  RequestType.find_or_create_by(verb: "POST"),
    event_name:    EventName.find_or_create_by(event: "socialLogin"),
    environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Safari"),
    resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
    ip: Ip.find_or_create_by(address: "63.29.38.211"),
    client: Client.find_by(identifier: "jumpstartlab")}
  end

  def payload13
    {url:           Url.find_or_create_by(path: "http://jumpstartlab.com"),
    requested_at:  "2013-02-16 23:00:00 -0700",
    responded_in:  30,
    referral:   Referral.find_or_create_by(path: "http://jumpstartlab.com/contact"),
    request_type:  RequestType.find_or_create_by(verb: "POST"),
    event_name:    EventName.find_or_create_by(event: "socialLogin"),
    environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Firefox"),
    resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
    ip: Ip.find_or_create_by(address: "63.29.38.211"),
    client: Client.find_by(identifier: "jumpstartlab")}
  end

  def payload14
    {url:           Url.find_or_create_by(path: "http://jumpstartlab.com/about"),
    requested_at:  "2013-02-16 01:00:00 -0700",
    responded_in:  30,
    referral:   Referral.find_or_create_by(path: "http://jumpstartlab.com/contact"),
    request_type:  RequestType.find_or_create_by(verb: "POST"),
    event_name:    EventName.find_or_create_by(event: "socialLogin"),
    environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Chrome"),
    resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
    ip: Ip.find_or_create_by(address: "63.29.38.211"),
    client: Client.find_by(identifier: "jumpstartlab")}
  end

  def payload15
    {url:           Url.find_or_create_by(path: "http://jumpstartlab.com/about"),
    requested_at:  "2013-02-16 01:00:00 -0700",
    responded_in:  15,
    referral:   Referral.find_or_create_by(path: "http://jumpstartlab.com/home"),
    request_type:  RequestType.find_or_create_by(verb: "POST"),
    event_name:    EventName.find_or_create_by(event: "socialLogin"),
    environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Chrome"),
    resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
    ip: Ip.find_or_create_by(address: "63.29.38.211"),
    client: Client.find_by(identifier: "jumpstartlab")}
  end

  def payload_missing_attribute
    {url:           Url.find_or_create_by(path: "http://jumpstartlab.com/about"),
    requested_at:  "2013-02-16 20:00:00 -0700",
    responded_in:  15,
    referral:   Referral.find_or_create_by(path: "http://jumpstartlab.com/home"),
    request_type:  RequestType.find_or_create_by(verb: "POST"),
    event_name:    EventName.find_or_create_by(event: "socialLogin"),
    environment:    Environment.find_or_create_by(os: "OS X 10.5.3", browser: "Chrome"),
    client: Client.find_by(identifier: "jumpstartlab")}
  end

  def unparsed_payload
    {
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
  end
end
