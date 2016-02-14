require_relative '../test_helper'
require_relative '../test_payloads'

class DeleteClientTest < Minitest::Test
  include Rack::Test::Methods
  include TestHelpers
  include TestPayloads

  def app
    RushHour::Server
  end

  def test_client_can_delete_their_account_and_data
    post '/sources', {"identifier"=>"jumpstartlab", "rootUrl"=>"http://jumpstartlab.com"}
    post '/sources', {"identifier"=>"testlab", "rootUrl"=>"http://testlab.com"}

    PayloadRequest.create(payload1)

    assert_equal 2, Client.count
    assert_equal 1, PayloadRequest.count
    # assert_equal 1, Url.count
    delete '/jumpstartlab/delete'

    assert_equal 1, Client.count
    assert_equal 0, PayloadRequest.count
    # assert_equal 0, Url.count
  end
end
