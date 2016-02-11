require_relative '../test_helper'
require 'json'

class ClientDataTest < Minitest::Test
  include Rack::Test::Methods
  include TestHelpers

  def app
    RushHour::Server
  end

  # def test_clients_can_post_payload_data
  #   skip
  #   client = Client.create(identifier: 'jumpstartlab', root_url: 'http://jumpstartlab.com')
  #
  #   payload = {
  #     url: "http://jumpstartlab.com/blog",
  #     requestedAt: "2013-02-16 21:38:28 -0700",
  #     respondedIn: 37,
  #     referredBy: "http://jumpstartlab.com",
  #     requestType: "GET",
  #     parameters: [],
  #     eventName: "socialLogin",
  #     userAgent: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
  #     resolutionWidth: "1920",
  #     resolutionHeight: "1280",
  #     ip: "63.29.38.211"
  #   }
  #
  #   post "/sources/#{client.identifier}/data", payload
  #
  #   assert_equal 200, last_response.status
  # end
end
