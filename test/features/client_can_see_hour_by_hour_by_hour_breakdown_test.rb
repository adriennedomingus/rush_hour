require_relative '../test_helper'
require_relative '../test_payloads'

class ClientCanSeeHourByHourBreakdownTest < FeatureTest
  include TestHelpers
  include TestPayloads

  def test_client_can_see_hour_by_hour_breakdown
    page.driver.browser.post('/sources?identifier=jumpstartlab&rootUrl=http://jumpstartlab.com')

    PayloadRequest.create(payload_one)
    PayloadRequest.create(payload_two)
    PayloadRequest.create(payload_three)

    visit '/events/jumpstartlab/socialLogin'

    assert page.has_content? "Hour 1: 2 hits"
    assert page.has_content? "Hour 21: 1 hits"
    assert page.has_content? "Hour 2: 0 hits"
  end
end
