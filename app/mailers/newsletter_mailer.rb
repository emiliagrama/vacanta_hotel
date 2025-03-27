class NewsletterMailer < ApplicationMailer
  def signup(email)
    mail(
      from: email,
      to: "emiliagrama@gmail.com", # your hotel email
      subject: "Newsletter Signup Request",
      body: "New newsletter signup from: #{email}"
    )
  end
end

