require_relative '../test_helper'
require 'json'

class DeleteClientTest < Minitest::Test
  include Rack::Test::Methods
  include TestHelpers

  def app
    RushHour::Server
  end

  def test_client_can_delete_their_account_and_data
    Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")

    assert_equal 1, Client.count

    post '/:identifier/delete', {"identifier"=>"jumpstartlab", "rootUrl"=>"http://jumpstartlab.com"}

    assert_equal 0, Client.count
  end

  # def test_client_cannot_delete_another_clients_data
  #   Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
  #
  #   assert_equal 1, Client.count
  #
  #   post '/:identifier/delete', {"identifier"=>"adam", "rootUrl"=>""}
  #
  #   assert_equal 1, Client.count
  # end
end
