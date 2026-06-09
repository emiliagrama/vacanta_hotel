# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  helper_method :current_admin

  private

  def current_admin
    @current_admin ||= AdminUser.find_by(id: session[:admin_user_id])
  end

  def require_admin
    redirect_to admin_login_path, alert: "Please log in." unless current_admin
  end
end
