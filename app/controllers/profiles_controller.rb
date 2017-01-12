class ProfilesController < ApplicationController
  
  # GET /users/:user_id/profile/new
  
  def new
    # Render profile form
    @profile = Profile.new
  end
  
  # POST to /users/:user_id/profile
  def create
    #get current user
    @user = User.find(params[:user_id])
    
    # create profile linked to current User
    @profile = @user.build_profile( profile_params)
    if @profile.save
      flash[:success] = "Profile successfully added"
      redirect_to user_path( params[:user_id])
    else
      flash[:error] = "Unable to add profile"
      render action: :new
    end
  end
  
  
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
    end
end