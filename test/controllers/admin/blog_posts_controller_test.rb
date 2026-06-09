require "test_helper"

class Admin::BlogPostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_blog_posts_index_url
    assert_response :success
  end
end
