class ProfilesController < ApplicationController
  
  # Be sure user is logged in before allowing access - devise built-in function
  before_action :authenticate_user!
  
  # Be sure this is the actual user accessing this profile for editing
  # function defined in private
  before_action :only_current_user
  
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
  
  # GET /users/:user_id/profile/edit
  def edit
    # Find user to link to profile
    @user = User.find( params[:user_id])
    
    # get user profile and pass to form
    @profile = @user.profile
  end
    
  # PUT /users/:userid/profile
  def update
    # Find current user 
    @user = User.find( params[:user_id])
    
    # get user profile 
    @profile = @user.profile
    #mass assign data and save
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile updated"
      #redirect user to their own profile page.
      redirect_to user_path(id: params[:user_id])
    else
      render action: :edit
    end
  end
  
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
    end
    
    def only_current_user
      @user = User.find(params[:user_id])
      redirect_to root_url unless @user == current_user
    end
end