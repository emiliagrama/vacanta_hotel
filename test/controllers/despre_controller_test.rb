require "test_helper"

class DespreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get despre_index_url
    assert_response :success
  end
end
