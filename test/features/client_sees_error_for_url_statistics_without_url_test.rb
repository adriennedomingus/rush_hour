require_relative '../test_helper'
require_relative '../test_payloads'

class ClientGetsErrorWithNoUrlTest < FeatureTest
  include TestHelpers
  include TestPayloads

  def test_missing_url_gives_sad_path
    create_client

    visit '/sources/jumpstartlab/urls/nottest'
    assert page.has_content? "Url (http://jumpstartlab.com/nottest) has not been requested."
  end
end
