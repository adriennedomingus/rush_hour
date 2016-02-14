require_relative '../test_helper'
require_relative '../test_payloads'

class ResolutionTest < MiniTest::Test
  include TestHelpers
  include TestPayloads

  def test_all_browsers_in_order
    create_client
    create_15_payloads

    result = ["1080 x 9000", "1920 x 1280", "4400 x 8800"]

    assert_equal result, Resolution.all_resolutions
  end
end
