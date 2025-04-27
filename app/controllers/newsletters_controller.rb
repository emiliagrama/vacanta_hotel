class NewslettersController < ApplicationController
  def create
    if cookies[:subscribed_to_newsletter]
      render json: { error: "Te-ai abonat deja la newsletter." }, status: :unprocessable_entity
      return
    end

    NewsletterMailer.signup(params[:email]).deliver_now
    cookies[:subscribed_to_newsletter] = { value: true, expires: 1.year.from_now }

    respond_to do |format|
      format.json { render json: { success: true } }
      format.html {
        flash[:notice] = "Mesaj transmis! Vei primi vești bune, fără spam."
        redirect_to root_path
      }
    end
  end
end
