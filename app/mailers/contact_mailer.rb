class ContactMailer < ApplicationMailer
  def new_inquiry
    @contact = params[:contact]
    mail(to: "emiliagrama@gmail.com", subject: "Cerere nouă de la #{@contact.name}")
  end
end
