class ContactMailer < ApplicationMailer
  def new_inquiry
    @contact = params[:contact]
    @variant_id  = params[:variant_id]
    @offer_hint  = params[:offer_hint]
    mail(
      to: "receptie@hotelvacanta.ro",
      from: "receptie@hotelvacanta.ro",  # ✅ required by your SMTP
      reply_to: @contact[:email].presence || "receptie@hotelvacanta.ro",
      subject: "Cerere nouă de la #{@contact[:name]}"
    )
  end
end
