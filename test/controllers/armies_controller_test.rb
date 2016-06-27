require 'test_helper'

class ArmiesControllerTest < ActionController::TestCase
  test 'should create an army that persists' do
    params = {
      army: {
        name: 'test_army',
        infantry: 30,
        archers: 60,
        knights: 120
      }
    }
    post :create, params
    army = assigns(:army)
    assert army.persisted?
    assert_redirected_to root_path
  end
end
