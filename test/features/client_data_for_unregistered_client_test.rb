require_relative '../test_helper'

class ClientDataForUnregisteredClientTest < FeatureTest
  include TestHelpers

  def test_accessing_client_data_without_registering
    visit '/sources/jumpstartlab'
    assert page.has_content? "Sorry, you have not registered your app yet"
  end
end
