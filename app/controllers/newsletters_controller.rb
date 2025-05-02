class NewslettersController < ApplicationController
  skip_before_action :verify_authenticity_token # Temporarily disable CSRF protection for API

  def create
    if cookies[:subscribed_to_newsletter]
      render json: { error: "Te-ai abonat deja la newsletter." }, status: :unprocessable_entity
      return
    end

    email = params[:email]

    # Ensure email exists before making the Mailchimp call
    if email.blank? || !email.include?('@')
      return render json: { error: "Invalid email address." }, status: :unprocessable_entity
    end

    # Call the Mailchimp service to subscribe the user
    mailchimp_service = MailchimpService.new
    response = mailchimp_service.subscribe(email)

    if response.success?
      # Set cookie for successful subscription
      cookies[:subscribed_to_newsletter] = { value: true, expires: 1.year.from_now }

      # Respond with success
      respond_to do |format|
        format.json { render json: { success: true } }
        format.html do
          flash[:notice] = "Mesaj trimis! Vei primi vesti bune, fără spam."
          redirect_to root_path
        end
      end
    else
      render json: { error: response.response.body || "Eroare la abonare. Încearcă din nou." }, status: :unprocessable_entity
    end
  end
end
