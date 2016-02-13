require_relative '../test_helper'

class ClientUrlPathDataForUnregisteredClientTest < FeatureTest
  include TestHelpers

  def test_accessing_client_url_path_data_without_registering
    visit '/jumpstartlab/events'
    assert page.has_content? "Sorry, you have not registered your app yet"
  end
end
