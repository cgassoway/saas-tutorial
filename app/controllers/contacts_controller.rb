class ContactsController < ApplicationController
  
  def new
    #create new contact in instance variable @contact
    # It connects with new form by using this variable
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(contact_params)
    if @contact.save()
      #Build email message if save successful
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:comments]
      ContactMailer.contact_email(name, email, body).deliver
      
      #Send success message and redirect
      flash[:success] = "Message sent"
      redirect_to new_contact_path
    else
      flash[:danger] = @contact.errors.full_messages.join(", ")
      redirect_to new_contact_path
    end
  end
  
  private
  
    def contact_params
      params.require(:contact).permit(:name, :email, :comments)
    end
  
end