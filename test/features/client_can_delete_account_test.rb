require_relative '../test_helper'

class ClientCanDeleteAccountTest < FeatureTest
  include TestHelpers

  def test_client_can_see_delete_page
    page.driver.browser.post('/sources?identifier=jumpstartlab&rootUrl=http://jumpstartlab.com')

    visit '/jumpstartlab/delete'
    assert page.has_content? 'Do you wish to delete your account?'
  end

  def test_client_directed_to_account_deleted_after_deleting_account
    page.driver.browser.post('/sources?identifier=jumpstartlab&rootUrl=http://jumpstartlab.com')
    visit '/jumpstartlab/delete'
    click_button 'Yes'
  
    assert page.has_content? 'Account deleted!'
    assert_equal '/jumpstartlab/delete', current_path

  end

end
