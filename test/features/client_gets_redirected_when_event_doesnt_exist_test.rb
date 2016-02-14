require_relative '../test_helper'
require_relative '../test_payloads'

class ClientRedirectedWhenEventDoesntExistTest < FeatureTest
  include TestHelpers
  include TestPayloads

  def test_client_gets_redirected_when_event_deosnt_exist
    page.driver.browser.post('/sources?identifier=jumpstartlab&rootUrl=http://jumpstartlab.com')
    create_15_payloads

    visit '/events/jumpstartlab/nonexistantEvent'
    assert_equal '/jumpstartlab/events', page.current_path
  end
end
