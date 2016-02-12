require_relative '../test_helper'

class ClientDataWithNoPayloads < FeatureTest
  include TestHelpers

  def test_accessing_client_data_with_no_payload

    page.driver.browser.post('/sources?identifier=jumpstartlab&rootUrl=http://jumpstartlab.com')

    visit '/sources/jumpstartlab'
    assert page.has_content? "You haven't submitted any paylaods"
  end
end
