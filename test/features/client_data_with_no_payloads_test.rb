require_relative '../test_helper'
require 'tilt/erb'

class ClientDataWithPayloadsandRegistrationTest < FeatureTest
  include TestHelpers

  def test_accessing_client_data_with_valid_payload

    page.driver.browser.post('/sources?identifier=jumpstartlab&rootUrl=http://jumpstartlab.com')

    PayloadRequest.create(payload_one)
    PayloadRequest.create(payload_two)
    PayloadRequest.create(payload_three)

    visit '/sources/jumpstartlab'
    assert page.has_content? "Average response time: 45"
    assert page.has_content? "Maximum response time: 60"
    assert page.has_content? "Maximum response time: 30"
    assert page.has_content? "Most frequent request type: GET"
    assert page.has_content? "All HTTP verbs: GET POST"
    assert page.has_content? "All URLS from most to least frequent: http://jumpstartlab.com/blog http://jumpstartlab.com/about"
    assert page.has_content? "Browsers used: Chrome Safari"
    assert page.has_content? "OS used: OS X 10.6.3 OS X 10.5.3"
    assert page.has_content? "Screen Resolutions used: 1920 x 1280 1080 x 9000"
  end

  def payload_one
    { url:           Url.find_or_create_by(path: "http://jumpstartlab.com/blog"),
      requested_at:  "2013-02-16 21:38:28 -0700",
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
      requested_at:  "2013-02-16 21:38:28 -0700",
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
