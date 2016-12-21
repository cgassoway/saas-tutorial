class ContactsController < ApplicationController
  
  def new
    #create new contact in instance variable @contact
    # It connects with new form by using this variable
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(contact_params)
    if @contact.save()
      flash[:success] = "Message sent"
      redirect_to new_contact_path
    else
      flash[:error] = @contact.errors.full_messages.join(", ")
      redirect_to new_contact_path, notice: "Error occurred"
    end
  end
  
  private
  
    def contact_params
      params.require(:contact).permit(:name, :email, :comments)
    end
  
end