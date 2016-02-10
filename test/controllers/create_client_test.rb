require_relative '../test_helper'
require 'json'

class CreateClientTest < Minitest::Test
  include Rack::Test::Methods
  include TestHelpers

  def app
    Server
  end

  def test_successful_request
    post '/sources', {"identifier"=>"jumpstartlab", "rootUrl"=>"http://jumpstartlab.com"}.to_json
  end

end
