require_relative '../test_helper'

class UserCanViewSpecificUrlStatistics < FeatureTest
  def payload1
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

  def payload2
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

  def payload3
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

  def payload4
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

  def payload5
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

  def payload6
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

  def test_payload_stats_can_be_viewed_by_client
    page.driver.browser.post('/sources?identifier=testlab&rootUrl=http://testlab.com')

    PayloadRequest.create(payload1)
    PayloadRequest.create(payload2)
    PayloadRequest.create(payload3)
    PayloadRequest.create(payload4)
    PayloadRequest.create(payload5)
    PayloadRequest.create(payload6)

    visit '/sources/testlab/urls/test'

    assert page.has_content? "Url Stats"
    assert page.has_content? "Max Response Time: 37"
    assert page.has_content? "Min Response Time: 30"
    assert page.has_content? "Response Times: "
    assert page.has_content? "Average Response Time: 33.6666666666666667"
    assert page.has_content? "Verbs Used: GET"
    assert page.has_content? "3 Most Popular Referrers: http://testlab.com"
    assert page.has_content? "Url Stats"
    assert page.has_content? "3 Most Popular User Agents: Chrome, OS X 10.5.3"
  end

  def test_missing_url_gives_sad_path
    page.driver.browser.post('/sources?identifier=testlab&rootUrl=http://testlab.com')

    PayloadRequest.create(payload1)
    PayloadRequest.create(payload2)
    PayloadRequest.create(payload3)

    visit '/sources/testlab/urls/nottest'

    assert page.has_content? "Url (http://testlab.com/nottest) has not been requested."
  end
end
