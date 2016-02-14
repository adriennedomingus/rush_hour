require_relative '../test_helper'
require_relative '../test_payloads'

class RequestTypeTest < MiniTest::Test
  include TestHelpers
  include TestPayloads

  def test_all_http_verbs_in_order
    create_client
    create_15_payloads

    result = ["POST", "GET", "PUT"]

    assert_equal result, RequestType.in_order
  end

  def test_most_frequent_request_type
    create_client
    create_15_payloads
    
    result = "POST"

    assert_equal result, RequestType.most_frequent
  end

end
