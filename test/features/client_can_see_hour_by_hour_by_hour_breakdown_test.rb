require_relative '../test_helper'

class ClientCanSeeHourByHourBreakdownTest < FeatureTest
  include TestHelpers

  def test_client_can_see_hour_by_hour_breakdown
    page.driver.browser.post('/sources?identifier=jumpstartlab&rootUrl=http://jumpstartlab.com')

    PayloadRequest.create(payload_one)
    PayloadRequest.create(payload_two)
    PayloadRequest.create(payload_three)

    visit '/events/jumpstartlab/socialLogin'
    assert page.has_content? "Hour 1: 2 hits"
    assert page.has_content? "Hour 21: 1 hits"
    assert page.has_content? "Hour 2: 0 hits"
  end

  def payload_one
    { url:           Url.find_or_create_by(path: "http://jumpstartlab.com/blog"),
      requested_at:  "2013-02-16 01:38:28 -0700",
      responded_in:  30,
      referral:   Referral.find_or_create_by(path: "http://jumpstartlab.com"),
      request_type:  RequestType.find_or_create_by(verb: "GET"),
      event_name:    EventName.find_or_create_by(event: "socialLogin"),
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
      event_name:    EventName.find_or_create_by(event: "socialLogin"),
      environment:    Environment.find_or_create_by(os: "OS X 10.6.3", browser: "Safari"),
      resolution:    Resolution.find_or_create_by(width: "1080", height: "9000"),
      ip: Ip.find_or_create_by(address: "63.29.38.211"),
      client: Client.find_by(identifier: "jumpstartlab")}
  end
end
