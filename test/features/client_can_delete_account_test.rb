require_relative '../test_helper'

class ClientCanDeleteAccountTest < FeatureTest
  include TestHelpers

  def test_client_can_see_delete_page
    visit '/:identifier/delete'
    assert page.has_content? 'Do you wish to delete your account?'
  end

  def test_client_directed_to_account_deleted_after_deleting_account
    skip
    page.driver.browser.post('/sources?identifier=jumpstartlab&rootUrl=http://jumpstartlab.com')
    page.driver.browser.post('/jumpstartlab/delete?identifier=jumpstartlab&rootUrl=http://jumpstartlab.com')

    assert_equal '/jumpstartlab/delete', current_path
    save_and_open_page
    assert page.has_content? 'Account deleted!'
  end
end
