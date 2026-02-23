require "test_helper"

class OzonoterapieControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get ozonoterapie_url
    assert_response :success
  end
end
