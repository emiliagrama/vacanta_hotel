class Admin::SessionsController < ApplicationController
  def new
  end

  def create
    admin = AdminUser.find_by(email: params[:email])

    if admin&.authenticate(params[:password])
      session[:admin_user_id] = admin.id
      redirect_to "/admin/blog_posts", notice: "Logged in successfully."
    else
      flash.now[:alert] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to admin_login_path, notice: "Logged out."
  end
end
