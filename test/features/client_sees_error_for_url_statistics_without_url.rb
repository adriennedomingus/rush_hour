require_relative '../test_helper'
require_relative '../test_payloads'

class ClientGetsErrorWithNoUrlTest < FeatureTest
  include TestHelpers
  include TestPayloads

  def test_missing_url_gives_sad_path
    page.driver.browser.post('/sources?identifier=testlab&rootUrl=http://testlab.com')

    PayloadRequest.create(payload_four)
    PayloadRequest.create(payload_five)
    PayloadRequest.create(payload_six)

    visit '/sources/testlab/urls/nottest'

    assert page.has_content? "Url (http://testlab.com/nottest) has not been requested."
  end
end
