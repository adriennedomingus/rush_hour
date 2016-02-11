require_relative '../test_helper'

class CreateClientTest < Minitest::Test
  include Rack::Test::Methods
  include TestHelpers

  def app
    RushHour::Server
  end

  def test_a_payload_is_successful
    Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")

    post '/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    assert_equal 1, PayloadRequest.count
    assert_equal 200, last_response.status
    assert_equal "Thanks for the payload jumpstartlab!", last_response.body
  end

  def test_a_payload_can_only_be_sent_once
    Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
    post '/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    assert_equal 1, PayloadRequest.count

    post '/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    assert_equal 1, PayloadRequest.count
    assert_equal 403, last_response.status
    assert_equal "Sorry jumpstartlab, you already submitted this payload", last_response.body
  end

  def test_a_payload_is_empty
    Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
    post '/sources/jumpstartlab/data', 'payload={}'

    response = "Requested at can't be blank, Responded in can't be blank, Url can't be blank, Ip can't be blank, Event name can't be blank, Environment can't be blank, Request type can't be blank, Referral can't be blank, Resolution can't be blank"

    assert_equal 0, PayloadRequest.count
    assert_equal 400, last_response.status
    assert_equal response, last_response.body
  end

  def test_client_does_not_exist
    post '/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    assert_equal 0, PayloadRequest.count
    assert_equal 403, last_response.status
    assert_equal "Sorry, it looks like you haven't registered your app jumpstartlab", last_response.body
  end

end
