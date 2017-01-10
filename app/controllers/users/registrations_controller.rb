class Users::RegistrationsController < Devise::RegistrationsController
  
  # Extend Devise behavior so that users signing up with the pro plan (plan id 2)
  # save with pecial Stripe subscription function in registrations_controller
  # Otherwise Devise signs up user normally
  def create
    # inherit create from Devise action and extend to User
    super do |resource|
      if params[:plan]
        resource.plan_id = params[:plan]
        if resource.plan_id == 2
          # create new function in models
          resource.save_with_subscription
        else
          resource.save
        end
      end
    end
  end
end