class ContactMailer < ActionMailer::Base
  default to: 'fbcwg123@gmail.com'
  
  #view folder has same name as class name(contact_mailer)
  # view file has same name as following function (contact-email.html.erb)
  def contact_email(name, email, body)
    @name = name
    @email = email
    @body = body
    
    mail(from: email, subject: 'Contact Form Message' )
  end
end