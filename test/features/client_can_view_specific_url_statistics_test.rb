require_relative '../test_helper'
require_relative '../test_payloads'

class UserCanViewSpecificUrlStatistics < FeatureTest
  include TestHelpers
  include TestPayloads

  def test_payload_stats_can_be_viewed_by_client
    page.driver.browser.post('/sources?identifier=testlab&rootUrl=http://testlab.com')

    PayloadRequest.create(payload_four)
    PayloadRequest.create(payload_five)
    PayloadRequest.create(payload_six)
    PayloadRequest.create(payload_seven)
    PayloadRequest.create(payload_eight)
    PayloadRequest.create(payload_nine)

    visit '/sources/testlab/urls/test'

    assert page.has_content? "Url Stats"
    assert page.has_content? "Max Response Time: 37"
    assert page.has_content? "Min Response Time: 30"
    assert page.has_content? "Response Times: "
    assert page.has_content? "Average Response Time: 33.6666666666666667"
    assert page.has_content? "Verbs Used: GET"
    assert page.has_content? "3 Most Popular Referrers: http://testlab.com"
    assert page.has_content? "Url Stats"
    assert page.has_content? "3 Most Popular User Agents: Chrome, OS X 10.5.3"
  end
end
