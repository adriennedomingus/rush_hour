require_relative '../test_helper'
require_relative '../test_payloads'

class UrlTest < MiniTest::Test
  include TestHelpers
  include TestPayloads

  def test_max_response_time
    create_client
    create_15_payloads

    url = Url.find(1)

    assert_equal 45, url.max_response_time
  end

  def test_min_response_time
    create_client
    create_15_payloads

    url = Url.find(1)

    assert_equal 30, url.min_response_time
  end

  def test_response_time_list_longest_to_shortest
    create_client
    create_15_payloads

    url = Url.find(1)

    assert_equal [45, 37, 30], url.response_times
  end

  def test_avg_response_time
    create_client
    create_15_payloads

    url = Url.find(1)

    assert_equal 34, url.avg_response_time.to_i
  end

  def test_verbs
    create_client
    create_15_payloads

    url = Url.find(1)

    assert_equal ['POST', 'GET'], url.verbs
  end

  def test_top_referers
    create_client
    create_15_payloads

    url = Url.find(1)
    result = ["http://jumpstartlab.com", "http://jumpstartlab.com/home", "http://jumpstartlab.com/contact"]

    assert_equal 3, url.top_referrers.count
    assert_equal result, url.top_referrers
  end

  def test_top_user_agents
    create_client
    create_15_payloads

    url = Url.find(1)
    result = ["Safari, OS X 10.6.3", "Chrome, OS X 10.5.3", "Safari, OS X 10.5.3"]

    assert_equal 3, url.top_user_agents.count
    assert_equal result, url.top_user_agents
  end

  def test_top_urls_in_order
    create_client
    create_15_payloads

    result = ["http://jumpstartlab.com/test", "http://jumpstartlab.com/blog", "http://jumpstartlab.com/about", "http://jumpstartlab.com"]

    assert_equal result, Url.in_order
  end
end
