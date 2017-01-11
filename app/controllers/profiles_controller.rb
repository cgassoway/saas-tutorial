class ProfilesController < ApplicationController
  
  # GET /users/:user_id/profile/new
  
  def new
    # Render profile form
    @profile = Profile.new
    
  end
end