require "test_helper"

class TimpLiberControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get timp_liber_index_url
    assert_response :success
  end
end
