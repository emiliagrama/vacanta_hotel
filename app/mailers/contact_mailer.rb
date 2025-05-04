class ContactMailer < ApplicationMailer
  def new_inquiry
    @contact = params[:contact]

    mail(
      to: "receptie@hotelvacanta.ro",
      from: "receptie@hotelvacanta.ro",  # ✅ required by your SMTP
      reply_to: @contact[:email].presence || "receptie@hotelvacanta.ro",
      subject: "Cerere nouă de la #{@contact[:name]}"
    )
  end
end
