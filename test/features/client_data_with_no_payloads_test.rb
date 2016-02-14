require_relative '../test_helper'
require_relative '../test_payloads'

class ClientDataWithNoPayloads < FeatureTest
  include TestHelpers
  include TestPayloads

  def test_accessing_client_data_with_no_payload
    create_client

    visit '/sources/jumpstartlab'
    assert page.has_content? "You haven't submitted any payloads"
  end
end
