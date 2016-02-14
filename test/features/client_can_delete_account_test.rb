require_relative '../test_helper'

class ClientCanDeleteAccountTest < FeatureTest
  include TestHelpers

  def test_client_can_see_delete_page
    visit '/:identifier/delete'
    assert page.has_content? 'Do you wish to delete your account?'
  end

  def test_client_redirected_to_account_deleted_after_deleting_account
    page.driver.browser.post('/:identifier/delete?identifier=jumpstartlab&rootUrl=http://jumpstartlab.com')

    assert_equal '/:identifier/delete', current_path
    assert page.has_content? 'Account deleted!'
  end
end
