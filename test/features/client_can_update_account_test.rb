require_relative '../test_helper'

class ClientCanUpdateAccountTest < FeatureTest
  include TestHelpers

  def test_client_update_account
    page.driver.browser.post('/sources?identifier=jumpstartlab&rootUrl=http://jumpstartlab.com')
    assert_equal 'jumpstartlab', Client.all.first.identifier

    visit '/jumpstartlab/update'
    fill_in 'client[identifier]', with: 'changedmyname'
    click_button 'Submit'
    assert_equal 'changedmyname', Client.all.first.identifier
  end

end
