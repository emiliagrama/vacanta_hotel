class ContactController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      # Optionally send an email to the hotel:
      ContactMailer.with(
        contact: @contact,
        variant_id: params[:variant_id],
        offer_hint: params[:offer_hint]
      ).new_inquiry.deliver_now
      # Set cookie if user opted for newsletter
      if @contact.newsletter
        cookies[:subscribed_to_newsletter] = { value: "true", path: "/", expires: 1.year.from_now }
      end

      # Redirect to thank-you page
      redirect_to contact_thank_you_path, notice: "Mesaj trimis cu succes!"
    else
      # Show the form again with error messages
      render :new
    end
  end

  def thank_you
    # a simple thank-you action
  end

  private

  def contact_params
    params.require(:contact).permit(
      :name, :phone, :email,
      :number_of_adults, :number_of_kids,
      :check_in_date, :check_out_date,
      :package, :preference_for_confirmation,
      :message, :newsletter
    )
  end
end
