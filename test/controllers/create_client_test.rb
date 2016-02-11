require_relative '../test_helper'
require 'json'

class CreateClientTest < Minitest::Test
  include Rack::Test::Methods
  include TestHelpers

  def app
    RushHour::Server
  end

  def test_successful_request
    post '/sources', {"identifier"=>"jumpstartlab", "rootUrl"=>"http://jumpstartlab.com"}

    response_body = "{\"identifier\":\"jumpstartlab\"}"

    assert_equal 1, Client.count
    assert_equal 200, last_response.status
    assert_equal response_body, last_response.body
  end

  def test_missing_parameters_request
    post '/sources', {"identifier"=>"", "rootUrl"=>""}

    response_body = "Identifier can't be blank, Root url can't be blank"

    assert_equal 0, Client.count
    assert_equal 400, last_response.status
    assert_equal response_body, last_response.body
  end

  def test_missing_one_parameter_request
    post '/sources', {"identifier"=>"adam", "rootUrl"=>""}

    response_body = "Root url can't be blank"

    assert_equal 0, Client.count
    assert_equal 400, last_response.status
    assert_equal response_body, last_response.body
  end

  def test_non_unique_identifier
    Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")

    response_body = "Identifier has already been taken"

    post '/sources', {"identifier"=>"jumpstartlab", "rootUrl"=>"http://jumpstartlab.com"}
    assert_equal 1, Client.count
    assert_equal 403, last_response.status
    assert_equal response_body, last_response.body
  end
end
