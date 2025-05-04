class NewsletterMailer < ApplicationMailer
  def signup(email)
    mail(
      from: email,
      to: "receptie@hotelvacanta.ro", # your hotel email
      subject: "Newsletter Signup Request",
      body: "New newsletter signup from: #{email}"
    )
  end
end
