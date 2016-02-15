require_relative '../test_helper'
require_relative '../test_payloads'

class EventNameTest < MiniTest::Test
  include TestHelpers
  include TestPayloads

  def test_top_events
    create_client
    create_15_payloads

    result = ["socialLogin", "yetAnother", "anotherEvent"]

    assert_equal result, EventName.in_order
  end

  def test_events_by_hour
    create_client
    create_15_payloads

    result = {1=>3, 2=>0, 3=>0, 4=>0, 5=>0, 6=>0, 7=>0, 8=>0, 9=>0, 10=>1, 11=>1, 12=>1, 13=>1, 14=>1, 15=>0, 16=>0, 17=>0, 18=>0, 19=>0, 20=>3, 21=>1, 22=>0, 23=>1, 24=>0}

    assert_equal result, EventName.find_by(:event => "socialLogin").by_hour
  end
end
