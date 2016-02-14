require_relative '../test_helper'
require_relative '../test_payloads'

class ClientDataWithPayloadsandRegistrationTest < FeatureTest
  include TestHelpers
  include TestPayloads

  def test_accessing_client_data_with_valid_payload
    create_client
    create_15_payloads

    visit '/sources/jumpstartlab'
    assert page.has_content? "Average response time: 33.9"
    assert page.has_content? "Maximum response time: 60"
    assert page.has_content? "Minimum response time: 15"
    assert page.has_content? "Most frequent request type: POST"
    assert page.has_content? "All HTTP verbs: POST GET PUT"
    assert page.has_content? "All URLS from most to least frequent:  http://jumpstartlab.com/test http://jumpstartlab.com/blog http://jumpstartlab.com/about http://jumpstartlab.com"
    assert page.has_content? "Browsers used: Chrome Safari Firefox"
    assert page.has_content? "OS used: OS X 10.5.3 OS X 10.6.3"
    assert page.has_content? "Screen Resolutions used: 1080 x 9000 1920 x 1280 4400 x 8800"
  end
end
