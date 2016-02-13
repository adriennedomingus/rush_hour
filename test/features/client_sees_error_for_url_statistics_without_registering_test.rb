require_relative '../test_helper'

class ClientGetsErrorWithoutRegistering < FeatureTest
  include TestHelpers

  def test_unregistered_client_has_no_events
    visit '/events/testlab/sociallogin'
    assert page.has_content? "Sorry, you have not registered your app yet"
  end
end
