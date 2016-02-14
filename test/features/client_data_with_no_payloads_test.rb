require_relative '../test_helper'
require_relative '../test_payloads'

class ClientDataWithNoPayloads < FeatureTest
  include TestHelpers
  include TestPayloads

  def test_accessing_client_data_with_no_payload

    page.driver.browser.post('/sources?identifier=jumpstartlab&rootUrl=http://jumpstartlab.com')

    visit '/sources/jumpstartlab'
    assert page.has_content? "You haven't submitted any paylaods"
  end
end
