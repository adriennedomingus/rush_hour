require_relative '../test_helper'
require_relative '../test_payloads'

class ClientDataWithPayloadsandRegistrationTest < FeatureTest
  include TestHelpers
  include TestPayloads

  def test_accessing_client_data_with_valid_payload
    page.driver.browser.post('/sources?identifier=jumpstartlab&rootUrl=http://jumpstartlab.com')

    PayloadRequest.create(payload_one)
    PayloadRequest.create(payload_two)
    PayloadRequest.create(payload_three)

    visit '/sources/jumpstartlab'
    assert page.has_content? "Average response time: 45"
    assert page.has_content? "Maximum response time: 60"
    assert page.has_content? "Maximum response time: 30"
    assert page.has_content? "Most frequent request type: GET"
    assert page.has_content? "All HTTP verbs: GET POST"
    assert page.has_content? "All URLS from most to least frequent: http://jumpstartlab.com/blog http://jumpstartlab.com/about"
    assert page.has_content? "Browsers used: Chrome Safari"
    assert page.has_content? "OS used: OS X 10.6.3 OS X 10.5.3"
    assert page.has_content? "Screen Resolutions used: 1920 x 1280 1080 x 9000"
  end
end
