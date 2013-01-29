require 'test_helper'

class CalculadorasControllerTest < ActionController::TestCase
  test "should get operar" do
    get :operar
    assert_response :success
  end

end
