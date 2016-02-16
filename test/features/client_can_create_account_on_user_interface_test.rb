require_relative '../test_helper'

class ClientCanCreateAccountOnUserInterfaceTest < FeatureTest
  include TestHelpers

  def test_client_can_create_account_jon_user_interface
    assert_equal 0, Client.count

    visit '/createaccount'
    fill_in 'identifier', with: 'testidentifier'
    fill_in 'rootUrl', with: 'testidentifier.com'
    click_button 'Submit'

    assert_equal 1, Client.count
    assert page.has_content? '{"identifier":"testidentifier"}'
  end

end
