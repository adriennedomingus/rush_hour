require_relative '../test_helper'
require_relative '../test_payloads'

class ClientCanSeeHourByHourBreakdownTest < FeatureTest
  include TestHelpers
  include TestPayloads

  def test_client_can_see_hour_by_hour_breakdown
    page.driver.browser.post('/sources?identifier=jumpstartlab&rootUrl=http://jumpstartlab.com')
    create_15_payloads

    visit '/events/jumpstartlab/socialLogin'

    assert page.has_content? "Hour 1: 3 hits"
    assert page.has_content? "Hour 13: 1 hit"
    assert page.has_content? "Hour 14: 1 hit"
    assert page.has_content? "Hour 20: 3 hits"
    assert page.has_content? "Hour 23: 1 hit"
    assert page.has_content? "Hour 24: 0 hits"
  end
end
