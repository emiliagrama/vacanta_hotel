require "test_helper"

class HiddenPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get termeni_si_conditii" do
    get hidden_pages_termeni_si_conditii_url
    assert_response :success
  end

  test "should get politica_confidentialitate" do
    get hidden_pages_politica_confidentialitate_url
    assert_response :success
  end

  test "should get politica_cookies" do
    get hidden_pages_politica_cookies_url
    assert_response :success
  end
end
