class ContactMailer < ApplicationMailer
  def new_inquiry
    @contact = params[:contact]
    mail(to: "receptie@hotelvacanta.ro", subject: "Cerere nouă de la #{@contact.name}")
  end
end
