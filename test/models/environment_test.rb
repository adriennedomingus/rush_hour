require_relative '../test_helper'
require_relative '../test_payloads'

class EnvironmentTest < MiniTest::Test
  include TestHelpers
  include TestPayloads

  def test_all_browsers_in_order
    create_client
    create_15_payloads

    result = ["Chrome", "Safari", "Firefox"]

    assert_equal result, Environment.browsers
  end

  def test_all_os_in_order
    create_client
    create_15_payloads

    result = ["OS X 10.5.3", "OS X 10.6.3"]

    assert_equal result, Environment.os
  end
end
