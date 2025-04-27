class NewslettersController < ApplicationController
  def create
    NewsletterMailer.signup(params[:email]).deliver_now

    respond_to do |format|
      format.json { head :ok }
       flash[:notice] = "Mesaj transmis! Vei primi vești bune, fără spam."
      format.html { redirect_to root_path } # fallback
    end
  end
end
