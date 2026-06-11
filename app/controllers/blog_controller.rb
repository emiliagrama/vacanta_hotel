class BlogController < ApplicationController
  def index
    @blog_posts = BlogPost.published
  end

  def show
    @blog_post = BlogPost.published.find_by!(slug: params[:slug])
  end
end