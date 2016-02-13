require_relative '../test_helper'

class ClientEventsForUnregisteredClientTest < FeatureTest
  include TestHelpers

  def test_accessing_client_events_without_registering
    visit '/sources/jumpstartlab/urls/blog'
    assert page.has_content? "Sorry, you have not registered your app yet"
  end
end
