class Admin::BlogPostsController < ApplicationController
  before_action :require_admin

  def index
  end
end
